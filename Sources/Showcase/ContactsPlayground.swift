// Copyright 2023–2026 Skip
import SwiftUI
import SkipKit
import SkipContacts

/// Demonstrates the major features of the SkipContacts framework: requesting permission,
/// fetching the device contacts, and creating and deleting contacts.
struct ContactsPlayground: View {
    @State var permission: String = "unknown"
    @State var contacts: [Contact] = []
    @State var message: String = ""
    @State var createdIDs: [String] = []

    var isAuthorized: Bool {
        permission == "authorized" || permission == "limited"
    }

    var body: some View {
        List {
            Section("Permission") {
                Text("Status: \(permission)")
                    .foregroundStyle(isAuthorized ? Color.green : Color.red)
                Button("Request Contacts Permission") {
                    Task { @MainActor in
                        permission = (await requestContactsPermission()).rawValue
                        logger.log("contacts permission: \(permission)")
                    }
                }
            }

            Section("Contacts (\(contacts.count))") {
                Button("Load Contacts") {
                    Task { @MainActor in loadContacts() }
                }
                .disabled(!isAuthorized)

                Button("Add Sample Contact") {
                    Task { @MainActor in addSampleContact() }
                }
                .disabled(!isAuthorized)

                if !createdIDs.isEmpty {
                    Button("Delete \(createdIDs.count) Added Sample(s)", role: .destructive) {
                        Task { @MainActor in deleteSamples() }
                    }
                }

                ForEach(contacts.prefix(50), id: \.id) { contact in
                    VStack(alignment: .leading, spacing: 2) {
                        Text(contact.displayName)
                            .font(.headline)
                        if let phone = contact.phoneNumbers.first?.value, !phone.isEmpty {
                            Text(phone)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        } else if let email = contact.emailAddresses.first?.value, !email.isEmpty {
                            Text(email)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
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
        .navigationTitle("Contacts")
        .task {
            permission = ContactManager.queryContactsPermission().rawValue
        }
    }

    /// Request contacts permission. On iOS and in Skip Lite the cross-platform `ContactManager` request
    /// is used directly; in Skip Fuse on Android that method is `@nobridge`, so the bridged
    /// `PermissionManager` is used instead (which performs the Android runtime permission request).
    func requestContactsPermission() async -> PermissionAuthorization {
        #if SKIP_MODE_FUSE
        _ = await PermissionManager.requestPermission(PermissionType.READ_CONTACTS)
        return await PermissionManager.requestPermission(PermissionType.WRITE_CONTACTS)
        #else
        return await ContactManager.requestContactsPermission()
        #endif
    }

    func loadContacts() {
        do {
            let result = try ContactManager.shared.getContacts()
            contacts = result.contacts
            message = "Loaded \(contacts.count) contact(s)"
        } catch {
            message = "Error loading contacts: \(error)"
            logger.error("contacts load error: \(error)")
        }
    }

    func addSampleContact() {
        do {
            let contact = Contact(
                givenName: "Skip",
                familyName: "Showcase",
                organizationName: "skip.tools",
                jobTitle: "Demo Contact",
                phoneNumbers: [ContactPhoneNumber(label: .mobile, value: "+1-555-0100")],
                emailAddresses: [ContactEmailAddress(label: .work, value: "showcase@skip.tools")]
            )
            let id = try ContactManager.shared.createContact(contact)
            createdIDs.append(id)
            message = "Created contact \(id)"
            loadContacts()
        } catch {
            message = "Error creating contact: \(error)"
            logger.error("contacts create error: \(error)")
        }
    }

    func deleteSamples() {
        do {
            try ContactManager.shared.deleteContacts(ids: createdIDs)
            message = "Deleted \(createdIDs.count) sample contact(s)"
            createdIDs = []
            loadContacts()
        } catch {
            message = "Error deleting contacts: \(error)"
            logger.error("contacts delete error: \(error)")
        }
    }
}
