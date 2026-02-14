// Copyright 2023–2026 Skip
import SwiftUI

struct NotificationPlayground: View {
    
    // MARK: - Variables
    @State private var isAuthorized: Bool = false
    
    @State private var now = Date()
    @State private var nextTriggerDate: Date?
    private  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private var secondsUntilNextTrigger: Int? {
        guard let nextTriggerDate = self.nextTriggerDate else { return nil }
        let seconds = Int(nextTriggerDate.timeIntervalSince(self.now))
        return seconds > 0 ? seconds : nil
    }
    
    private let notificationCenterDelegate = NotificationCenterDelegate()
    
    // MARK: - Initialization
    
    /// Initializes a new instance of the `NotificationPlayground` struct.
    init() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.delegate = self.notificationCenterDelegate
    }
    
    // MARK: - View
    var body: some View {
        VStack(spacing: 20) {
            Text("Is Authorized: \(self.isAuthorized ? "True" : "False")")
            
            VStack(spacing: 10) {
                Button("Request Notification Permission") {
                    Task {
                        await self.requestNotificationPermission()
                    }
                }
                .buttonStyle(.bordered)
                .disabled(self.isAuthorized)
                
                Button("Trigger Immediate Notification") {
                    Task {
                        await self.addNotificationRequest(
                            title: "Title",
                            body: "Body",
                            identifier: UUID().uuidString
                        )
                    }
                }
                .backgroundStyle(.blue)
                .buttonStyle(.borderedProminent)
                .disabled(!self.isAuthorized)
                
                Button("Trigger Scheduled Notification") {
                    Task {
                        await self.addNotificationRequest(
                            title: "Title",
                            body: "Body",
                            identifier: UUID().uuidString,
                            trigger: {
                                let result = UNTimeIntervalNotificationTrigger(
                                    timeInterval: 10,
                                    repeats: false
                                )
                                self.nextTriggerDate = result.nextTriggerDate()
                                return result
                            }()
                        )
                    }
                }
                .backgroundStyle(.blue)
                .buttonStyle(.borderedProminent)
                .disabled(!self.isAuthorized || self.secondsUntilNextTrigger != nil)
            }
            
            if let seconds = self.secondsUntilNextTrigger {
                Text("Next notification in \(seconds) s")
                    .foregroundStyle(.secondary)
                
                Button("Remove all pending notifications") {
                    self.removeAllPendingNotifications()
                    self.nextTriggerDate = nil
                }
                .foregroundStyle(.red)
            } else {
                Text("No scheduled notification")
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Notifications")
        .onAppear {
            Task {
                await self.requestNotificationPermission()
            }
        }
        .onReceive(self.timer) { input in
            self.now = input
        }
    }
    
    /// Requests the permission to push notifications.
    private func requestNotificationPermission() async {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        let notificationCenter = UNUserNotificationCenter.current()
        self.isAuthorized = (try? await notificationCenter.requestAuthorization(options: options)) ?? false
    }
    
    /// Adds a new notification request.
    ///
    /// - Parameters:
    ///   - title: The notification title.
    ///   - body: The notification body.
    ///   - identifier: The notification identifier.
    ///   - trigger: The (optional) notification trigger. If nil, the notification will trigger immediately.
    private func addNotificationRequest(
        title: String,
        body: String,
        identifier: String,
        trigger: UNNotificationTrigger? = nil
    ) async {
        
        // Create a new notificiation content.
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.userInfo = [
            "identifier": UUID().uuidString
        ]
        
        // Create a new notification request.
        let request = UNNotificationRequest(
            identifier: identifier,
            content: content,
            trigger: trigger
        )
        
        // Schedule the delivery of the notification.
        let notificationCenter = UNUserNotificationCenter.current()
        try? await notificationCenter.add(request)
    }
    
    /// Removes all pending notification requests.
    private func removeAllPendingNotifications() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removeAllPendingNotificationRequests()
    }
}

// MARK: - UNUserNotificationCenterDelegate
private final class NotificationCenterDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    /// Asks the delegate how to handle a notification that arrived while the app was running in the foreground.
    ///
    /// - Parameters:
    ///   - center: The shared user notification center object that received the notification.
    ///   - notification: The notification that is about to be delivered.
    /// - Returns: Constants indicating how to present a notification in a foreground app.
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification
    ) async -> UNNotificationPresentationOptions {
        return [.banner, .sound, .badge]
    }
}
