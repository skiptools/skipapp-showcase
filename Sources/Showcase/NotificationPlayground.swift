// Copyright 2023–2026 Skip
import SwiftUI
import SkipKit
import SkipNotify

struct NotificationPlayground: View {
    @State var notificationPermission: String = ""
    
    var body: some View {
        List {
            Section {
                Text("Permission Status: \(self.notificationPermission)")
                    .task {
                        self.notificationPermission = await PermissionManager.queryPostNotificationPermission().rawValue
                    }
                    .foregroundStyle(self.notificationPermission == "authorized" ? .green : .red)
                
                Button("Request Push Notification Permission") {
                    Task { @MainActor in
                        do {
                            self.notificationPermission = try await PermissionManager.requestPostNotificationPermission(alert: true, sound: false, badge: true).rawValue
                            logger.log("obtained push notification permission: \(self.notificationPermission)")
                        } catch {
                            logger.error("error obtaining push notification permission: \(error)")
                            self.notificationPermission = "error: \(error)"
                        }
                    }
                }
                .buttonStyle(.plain)
            }
            
            Section {
                NavigationLink("Skip Notify") {
                    SkipNotifyNotificationPlaygroundView()
                }
                
                NavigationLink("Local Notifications") {
                    LocalNotificationPlaygroundView()
                }
            }
        }
        .navigationTitle("Notification")
    }
}

struct SkipNotifyNotificationPlaygroundView: View {
    @State var token: String = ""
    var body: some View {
        VStack {
            HStack {
                TextField("Push Notification Client Token", text: $token)
                    .textFieldStyle(.roundedBorder)
                Button("Copy") {
                    UIPasteboard.general.string = token
                }
                .buttonStyle(.automatic)
            }

            Button("Generate Push Notification Token") {
                Task { @MainActor in
                    do {
                        self.token = try await SkipNotify.shared.fetchNotificationToken()
                        logger.log("obtained push notification token: \(self.token)")
                    } catch {
                        logger.error("error obtaining push notification token: \(error)")
                    }
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Skip Notify")
        .padding()
    }
}

struct LocalNotificationPlaygroundView: View {
    @State var timerDate: Date?
    @State var nextTriggerDate: Date?
    let timer = Timer.publish(every: 1.0, on: .main, in: .default).autoconnect()
    private var secondsUntilNextTrigger: Int? {
        guard let timerDate, let nextTriggerDate else { return nil }
        let seconds = Int(nextTriggerDate.timeIntervalSince(timerDate))
        return seconds > 0 ? seconds : nil
    }
    
    private let notificationCenterDelegate = NotificationCenterDelegate()
    
    init() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.delegate = self.notificationCenterDelegate
    }
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 10) {
                Button("Trigger Immediate Push Notification") {
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
                
                Button("Trigger Scheduled Push Notification") {
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
                .disabled(self.secondsUntilNextTrigger != nil)
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
        .navigationTitle("Local Notifications")
        .onReceive(self.timer) { date in
            self.timerDate = Date()
        }
    }
    
    private func addNotificationRequest(
        title: String,
        body: String,
        identifier: String,
        trigger: UNNotificationTrigger? = nil
    ) async {
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.userInfo = [
            "identifier": UUID().uuidString
        ]
        
        let request = UNNotificationRequest(
            identifier: identifier,
            content: content,
            trigger: trigger
        )
        
        let notificationCenter = UNUserNotificationCenter.current()
        try? await notificationCenter.add(request)
    }
    
    private func removeAllPendingNotifications() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removeAllPendingNotificationRequests()
    }
}

private final class NotificationCenterDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification
    ) async -> UNNotificationPresentationOptions {
        return [.banner]
    }
}
