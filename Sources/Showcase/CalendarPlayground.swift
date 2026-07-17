// Copyright 2023–2026 Skip
import SwiftUI
import SkipKit
import SkipCalendar

/// Demonstrates the major features of the SkipCalendar framework: requesting permission,
/// listing calendars, querying upcoming events, presenting the native event editor and viewer,
/// and creating and deleting events.
struct CalendarPlayground: View {
    @State var permission: String = "unknown"
    @State var calendars: [CalendarItem] = []
    @State var events: [CalendarEvent] = []
    @State var message: String = ""
    @State var createdEventIDs: [String] = []
    @State var showEventEditor = false
    @State var showEventViewer = false
    @State var viewerEventID = ""
    @State var selectedEvent: CalendarEvent? = nil

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

            Section("Native Event UI") {
                // EventKit has no system event picker, so the native event editor (EKEventEditViewController)
                // is used to compose an event; tap a listed event below to open the native viewer.
                Button("New Event in Native Editor…") {
                    showEventEditor = true
                }
                .disabled(!isAuthorized)
            }

            if let event = selectedEvent {
                Section("Selected Event") {
                    eventRow("Title", event.title)
                    eventRow("Starts", eventDateFormatter.string(from: event.startDate))
                    eventRow("Ends", eventDateFormatter.string(from: event.endDate))
                    if let location = event.location, !location.isEmpty {
                        eventRow("Location", location)
                    }
                    if let notes = event.notes, !notes.isEmpty {
                        eventRow("Notes", notes)
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

                // Tap an event to view it in the native viewer and show its details above.
                ForEach(events, id: \.id) { event in
                    Button {
                        viewEvent(event)
                    } label: {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(event.title)
                                .font(.headline)
                            Text(eventDateFormatter.string(from: event.startDate))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .buttonStyle(.plain)
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
        .withEventEditor(isPresented: $showEventEditor, options: eventEditorOptions(), onComplete: { result in
            message = "Native editor: \(result.rawValue)"
            if result == .saved {
                loadEvents()
            }
        })
        .withEventViewer(isPresented: $showEventViewer, eventID: viewerEventID, onComplete: { _ in })
    }

    @ViewBuilder func eventRow(_ label: String, _ value: String) -> some View {
        HStack {
            Text(label)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .multilineTextAlignment(.trailing)
        }
        .font(.subheadline)
    }

    /// A pre-filled sample event for the native editor.
    func eventEditorOptions() -> EventEditorOptions {
        let start = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
        let end = Calendar.current.date(byAdding: .hour, value: 2, to: Date()) ?? Date()
        return EventEditorOptions(
            defaultTitle: "Skip Showcase Event",
            defaultLocation: "Anywhere",
            defaultNotes: "Composed in the native event editor from the Showcase Calendar playground",
            defaultStartDate: start,
            defaultEndDate: end
        )
    }

    /// Show the selected event's details in-app and open the native event viewer.
    func viewEvent(_ event: CalendarEvent) {
        selectedEvent = event
        if let id = event.id, !id.isEmpty {
            viewerEventID = id
            showEventViewer = true
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
