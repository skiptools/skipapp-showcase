// Copyright 2023–2026 Skip
import SwiftUI
import SkipKit
import SkipContacts

/// Demonstrates the major features of the SkipContacts framework: requesting permission,
/// fetching the device contacts, presenting the native contact picker, and creating and
/// deleting contacts.
struct ContactsPlayground: View {
    @State var permission: String = "unknown"
    @State var contacts: [Contact] = []
    @State var message: String = ""
    @State var createdIDs: [String] = []
    @State var showContactPicker = false
    @State var selectedContact: Contact? = nil

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

            Section("Native Picker") {
                // The system contact picker presents in its own process, so it works without the app
                // holding contacts permission; the selected contact's full details are then loaded below.
                Button("Pick a Contact…") {
                    showContactPicker = true
                }
            }

            if let contact = selectedContact {
                Section("Selected Contact") {
                    contactRow("Name", contact.displayName)
                    if !contact.organizationName.isEmpty {
                        contactRow("Organization", contact.organizationName)
                    }
                    if !contact.jobTitle.isEmpty {
                        contactRow("Title", contact.jobTitle)
                    }
                    ForEach(contact.phoneNumbers, id: \.value) { phone in
                        contactRow("Phone (\(phone.label.rawValue))", phone.value)
                    }
                    ForEach(contact.emailAddresses, id: \.value) { email in
                        contactRow("Email (\(email.label.rawValue))", email.value)
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
        .withContactPicker(isPresented: $showContactPicker, onSelectContact: { contactID in
            selectContact(contactID)
        })
    }

    @ViewBuilder func contactRow(_ label: String, _ value: String) -> some View {
        HStack {
            Text(label)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .multilineTextAlignment(.trailing)
        }
        .font(.subheadline)
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

    /// Load the full details of the contact chosen in the native picker so they can be displayed.
    func selectContact(_ contactID: String) {
        do {
            if let contact = try ContactManager.shared.getContact(id: contactID) {
                selectedContact = contact
                message = "Picked contact: \(contact.displayName)"
            } else {
                message = "Picked contact \(contactID) — grant Contacts permission to view details"
            }
        } catch {
            message = "Picked contact \(contactID); could not load details: \(error)"
            logger.error("contacts getContact error: \(error)")
        }
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
