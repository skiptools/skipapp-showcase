// Copyright 2023–2026 Skip
import SwiftUI
import SkipKit
import SkipCalendar

/// Demonstrates the major features of the SkipCalendar framework: requesting permission,
/// listing calendars, querying upcoming events, and creating and deleting events.
struct CalendarPlayground: View {
    @State var permission: String = "unknown"
    @State var calendars: [CalendarItem] = []
    @State var events: [CalendarEvent] = []
    @State var message: String = ""
    @State var createdEventIDs: [String] = []

    var isAuthorized: Bool {
        permission == "authorized" || permission == "limited"
    }

    var body: some View {
        List {
            Section("Permission") {
                Text("Status: \(permission)")
                    .foregroundStyle(isAuthorized ? Color.green : Color.red)
                Button("Request Calendar Permission") {
                    Task { @MainActor in
                        permission = (await requestCalendarPermission()).rawValue
                        logger.log("calendar permission: \(permission)")
                    }
                }
            }

            Section("Calendars (\(calendars.count))") {
                Button("Load Calendars") {
                    Task { @MainActor in loadCalendars() }
                }
                .disabled(!isAuthorized)

                ForEach(calendars, id: \.id) { cal in
                    HStack {
                        Text(cal.title)
                        Spacer()
                        if cal.isReadOnly {
                            Text("read-only")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        if cal.isPrimary {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                                .font(.caption)
                        }
                    }
                }
            }

            Section("Upcoming Events (\(events.count))") {
                Button("Load Next 30 Days") {
                    Task { @MainActor in loadEvents() }
                }
                .disabled(!isAuthorized)

                Button("Add Sample Event") {
                    Task { @MainActor in addSampleEvent() }
                }
                .disabled(!isAuthorized)

                if !createdEventIDs.isEmpty {
                    Button("Delete \(createdEventIDs.count) Added Sample(s)", role: .destructive) {
                        Task { @MainActor in deleteSamples() }
                    }
                }

                ForEach(events, id: \.id) { event in
                    VStack(alignment: .leading, spacing: 2) {
                        Text(event.title)
                            .font(.headline)
                        Text(eventDateFormatter.string(from: event.startDate))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }

            if !message.isEmpty {
                Section {
                    Text(message)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle("Calendar")
        .task {
            permission = CalendarManager.queryCalendarPermission().rawValue
        }
    }

    /// Request calendar permission. On iOS and in Skip Lite the cross-platform `CalendarManager` request
    /// is used directly; in Skip Fuse on Android that method is `@nobridge`, so the bridged
    /// `PermissionManager` is used instead (which performs the Android runtime permission request).
    func requestCalendarPermission() async -> PermissionAuthorization {
        #if SKIP_MODE_FUSE
        _ = await PermissionManager.requestPermission(PermissionType.READ_CALENDAR)
        return await PermissionManager.requestPermission(PermissionType.WRITE_CALENDAR)
        #else
        return await CalendarManager.requestCalendarPermission()
        #endif
    }

    func loadCalendars() {
        do {
            calendars = try CalendarManager.shared.getCalendars()
            message = "Loaded \(calendars.count) calendar(s)"
        } catch {
            message = "Error loading calendars: \(error)"
            logger.error("calendar load error: \(error)")
        }
    }

    func loadEvents() {
        do {
            let start = Date()
            let end = Calendar.current.date(byAdding: .day, value: 30, to: start) ?? start
            events = try CalendarManager.shared.getEvents(startDate: start, endDate: end)
            message = "Loaded \(events.count) event(s) over the next 30 days"
        } catch {
            message = "Error loading events: \(error)"
            logger.error("calendar events error: \(error)")
        }
    }

    func addSampleEvent() {
        do {
            guard let cal = try CalendarManager.shared.getDefaultCalendar() else {
                message = "No writable calendar available"
                return
            }
            let start = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
            let end = Calendar.current.date(byAdding: .hour, value: 2, to: Date()) ?? Date()
            let event = CalendarEvent(
                calendarID: cal.id,
                title: "Skip Showcase Event",
                location: "Anywhere",
                notes: "Created by the Showcase Calendar playground",
                startDate: start,
                endDate: end
            )
            let id = try CalendarManager.shared.createEvent(event)
            createdEventIDs.append(id)
            message = "Created event \(id) in “\(cal.title)”"
            loadEvents()
        } catch {
            message = "Error creating event: \(error)"
            logger.error("calendar create error: \(error)")
        }
    }

    func deleteSamples() {
        for id in createdEventIDs {
            do {
                try CalendarManager.shared.deleteEvent(id: id)
            } catch {
                logger.error("calendar delete error: \(error)")
            }
        }
        message = "Deleted \(createdEventIDs.count) sample event(s)"
        createdEventIDs = []
        loadEvents()
    }
}

private let eventDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
}()
