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
                        // Firebase FCM senderID obtained from "Project number" at:
                        // https://console.firebase.google.com/project/app-fair-425519/settings/general/android:org.appfair.app.Showcase
                        self.token = try await SkipNotify.shared.fetchNotificationToken(firebaseProjectNumber: "25594159619")
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
    private var secondsUntilNextTrigger: Int? {
        guard let timerDate, let nextTriggerDate else { return nil }
        let seconds = Int(nextTriggerDate.timeIntervalSince(timerDate))
        return seconds > 0 ? seconds : nil
    }
    
    private let taps = NotificationTapLog.shared
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 10) {
                Button("Trigger Immediate Push Notification") {
                    Task {
                        await self.addNotificationRequest(
                            title: "Title",
                            body: "Body",
                            identifier: self.taps.nextIdentifier("immediate")
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
                            identifier: self.taps.nextIdentifier("scheduled"),
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
            
            Divider()
            
            NotificationTapsView(taps: self.taps)
        }
        .navigationTitle("Local Notifications")
        .task {
            while !Task.isCancelled {
                do {
                    try await Task.sleep(for: .seconds(1))
                    self.timerDate = Date()
                } catch {
                }
            }
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

/// The taps the user has made on this app's notifications since launch, newest first.
///
/// A tap reaches `didReceive` whether the app is open, in the background, or was swiped away:
/// in the last case it launches the app. Showing each one here is how the delivery is verified.
@MainActor @Observable final class NotificationTapLog {
    static let shared = NotificationTapLog()
    
    struct Tap: Identifiable {
        let id = UUID()
        let identifier: String
        let actionIdentifier: String
        let received = Date()
        
        /// What the user did: "opened" for the default action, else the action's identifier.
        var action: String {
            return actionIdentifier == UNNotificationDefaultActionIdentifier ? "opened" : actionIdentifier
        }
    }
    
    private(set) var taps: [Tap] = []
    private var requestCount = 0
    
    private init() {
    }
    
    func record(identifier: String, actionIdentifier: String) {
        taps.insert(Tap(identifier: identifier, actionIdentifier: actionIdentifier), at: 0)
    }
    
    func clear() {
        taps = []
    }
    
    /// A readable identifier for the next request, numbered in the order the requests were made.
    func nextIdentifier(_ kind: String) -> String {
        requestCount += 1
        return "\(kind)-\(requestCount)"
    }
}

/// The taps received so far, with a hint on how to produce one while none has arrived.
struct NotificationTapsView: View {
    let taps: NotificationTapLog
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Taps received")
                .font(.headline)
            if taps.taps.isEmpty {
                Text("Tap a notification to see it here. Try it with the app open, in the background, and after swiping it away.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            } else {
                ForEach(taps.taps) { tap in
                    HStack {
                        Text(tap.identifier)
                        Spacer()
                        Text(tap.action)
                            .foregroundStyle(.secondary)
                        Text(tap.received, style: .time)
                            .foregroundStyle(.secondary)
                    }
                    .font(.callout)
                    .padding(.horizontal)
                }
                Button("Clear") {
                    taps.clear()
                }
            }
        }
    }
}

/// Shows banners while the app is open and hands every tap to the `NotificationTapLog`.
final class NotificationCenterDelegate: NSObject, UNUserNotificationCenterDelegate, Sendable {
    private static let shared = NotificationCenterDelegate()
    
    /// Makes this the notification center's delegate. Runs at launch, before any tap can arrive: iOS
    /// delivers the tap that launched the app only to a delegate set before launch finishes.
    static func install() {
        UNUserNotificationCenter.current().delegate = shared
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification
    ) async -> UNNotificationPresentationOptions {
        return [.banner]
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse
    ) async {
        // The response is not Sendable; its two strings are.
        let identifier = response.notification.request.identifier
        let actionIdentifier = response.actionIdentifier
        await NotificationTapLog.shared.record(identifier: identifier, actionIdentifier: actionIdentifier)
    }
}
