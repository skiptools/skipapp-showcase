// Copyright 2023–2025 Skip
import SwiftUI

struct AlertPlayground: View {
    @State var value = ""
    @State var error: AlertPlaygroundError? = nil
    @State var data: Int? = nil
    @State var titleIsPresented = false
    @State var titleMessageIsPresented = false
    @State var longMessageIsPresented = false
    @State var longButtonTitlesIsPresented = false
    @State var twoButtonsIsPresented = false
    @State var titleDialogIsPresented = false
    @State var titleMessageDialogIsPresented = false
    @State var longMessageDialogIsPresented = false
    @State var longButtonTitlesDialogIsPresented = false
    @State var twoButtonsDialogIsPresented = false
    @State var threeButtonsIsPresented = false
    @State var fiveButtonsIsPresented = false
    @State var textFieldIsPresented = false
    @State var secureFieldIsPresented = false
    @State var textFieldText = ""
    @State var secureFieldText = ""
//    @State var errorIsPresented = false
    @State var dataIsPresented = false

    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 16) {
                Text(value).bold()
                Group {
                    Button("Title") {
                        titleIsPresented = true
                    }
                    Button("Title + Message") {
                        titleMessageIsPresented = true
                    }
                    Button("Long Message") {
                        longMessageIsPresented = true
                    }
                    Button("Long Button Titles") {
                        longButtonTitlesIsPresented = true
                    }
                    Button("Two Buttons") {
                        twoButtonsIsPresented = true
                    }
                    Button("Three Buttons") {
                        threeButtonsIsPresented = true
                    }
                    Button("Five Buttons") {
                        fiveButtonsIsPresented = true
                    }
                }
                #if SKIP
                Divider()
                Group {
                    Text("AlertDialog (Material3)")
                    Button("Title (Dialog)") {
                        titleDialogIsPresented = true
                    }
                    Button("Title + Message (Dialog)") {
                        titleMessageDialogIsPresented = true
                    }
                    Button("Long Message (Dialog)") {
                        longMessageDialogIsPresented = true
                    }
                    Button("Long Button Titles (Dialog)") {
                        longButtonTitlesDialogIsPresented = true
                    }
                    Button("Two Buttons (Dialog)") {
                        twoButtonsDialogIsPresented = true
                    }
                }
                Divider()
                #endif
                Group {
                    Button("Text Field") {
                        textFieldIsPresented = true
                    }
                    Button("Secure Field") {
                        secureFieldIsPresented = true
                    }
                }
                Divider()
    //            Group {
    //                Text("Present with error")
    //                Button("Error: \(String(describing: error))") {
    //                    error = AlertPlaygroundError.testError
    //                }
    //                Button("Nil error") {
    //                    error = nil
    //                }
    //                Button("Present") {
    //                    errorIsPresented = true
    //                }
    //            }
    //            Divider()
                Group {
                    Text("Present with data")
                    Button("Data: \(String(describing: data))") {
                        if data == nil {
                            data = 1
                        } else {
                            data = data! + 1
                        }
                    }
                    Button("Nil data") {
                        data = nil
                    }
                    Button("Present") {
                        dataIsPresented = true
                    }
                }
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "AlertPlayground.swift")
        }
        .alert("Title", isPresented: $titleIsPresented) {
        }
        .alert("Title + Message", isPresented: $titleMessageIsPresented) {
        } message: {
            Text("This is the alert message to show beneath the title")
        }
        .alert("Long Message", isPresented: $longMessageIsPresented) {
        } message: {
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed commodo consectetur odio. Proin tempus orci ut tortor tincidunt elementum. Morbi finibus neque eget ullamcorper convallis. Suspendisse metus est, rhoncus vitae commodo non, ultricies ac leo. Proin scelerisque eros sed dolor dignissim accumsan id a nulla. Nulla tempor consequat nulla vel consequat. Etiam congue pretium sagittis. Quisque quis commodo velit, ac cursus massa. Aenean commodo congue velit in vestibulum. Proin viverra orci efficitur faucibus aliquet. Ut dignissim justo at dolor placerat, venenatis pulvinar dui consectetur. Nunc eget diam nec eros finibus finibus. Mauris et risus sit amet diam sagittis dapibus eu ac odio. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed commodo consectetur odio. Proin tempus orci ut tortor tincidunt elementum. Morbi finibus neque eget ullamcorper convallis. Suspendisse metus est, rhoncus vitae commodo non, ultricies ac leo. Proin scelerisque eros sed dolor dignissim accumsan id a nulla. Nulla tempor consequat nulla vel consequat. Etiam congue pretium sagittis. Quisque quis commodo velit, ac cursus massa. Aenean commodo congue velit in vestibulum. Proin viverra orci efficitur faucibus aliquet. Ut dignissim justo at dolor placerat, venenatis pulvinar dui consectetur. Nunc eget diam nec eros finibus finibus. Mauris et risus sit amet diam sagittis dapibus eu ac odio. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed commodo consectetur odio. Proin tempus orci ut tortor tincidunt elementum. Morbi finibus neque eget ullamcorper convallis. Suspendisse metus est, rhoncus vitae commodo non, ultricies ac leo. Proin scelerisque eros sed dolor dignissim accumsan id a nulla. Nulla tempor consequat nulla vel consequat. Etiam congue pretium sagittis. Quisque quis commodo velit, ac cursus massa. Aenean commodo congue velit in vestibulum. Proin viverra orci efficitur faucibus aliquet. Ut dignissim justo at dolor placerat, venenatis pulvinar dui consectetur. Nunc eget diam nec eros finibus finibus. Mauris et risus sit amet diam sagittis dapibus eu ac odio.")
        }
        .alert("Alert Title?", isPresented: $longButtonTitlesIsPresented) {
            Button("Long destructive button text", role: .destructive) {
            }
            Button("Long cancel button text", role: .cancel) {
            }
        } message: {
            Text("Long message body for the alert which is displayed in skip")
        }
        .alert("Two Buttons", isPresented: $twoButtonsIsPresented) {
            Button("Option") {
                value = "Option"
            }
            AlertCancelButton(value: $value)
        }
        .alert("Three Buttons", isPresented: $threeButtonsIsPresented) {
            AlertCancelButton(value: $value)
            Button("Option") {
                value = "Option"
            }
            AlertDestructiveButton(value: $value)
        }
        .alert("Five Buttons", isPresented: $fiveButtonsIsPresented) {
            AlertCancelButton(value: $value)
            AlertDestructiveButton(value: $value)
            Button("Option 1") {
                value = "Option 1"
            }
            Button("Option 2") {
                value = "Option 2"
            }
            Button("Option 3") {
                value = "Option 3"
            }
        }
        .alert("Text Field", isPresented: $textFieldIsPresented) {
            TextField("Enter text", text: $textFieldText)
            Button("Submit") {
                value = textFieldText
            }
            AlertCancelButton(value: $value)
        }
        .alert("Sign In", isPresented: $secureFieldIsPresented) {
            TextField("Username", text: $textFieldText)
            SecureField("Password", text: $secureFieldText)
            Button("Submit") {
                value = textFieldText
            }
            AlertCancelButton(value: $value)
        }
        .alert("Data", isPresented: $dataIsPresented, presenting: data) { d in
            Button("Data: \(d)") {
                value = "\(d)"
            }
            Button("Nil Data", role: .destructive) {
                data = nil
            }
        }
        //        .alert(isPresented: $errorIsPresented, error: error) {
        //            Button("Error: \(String(describing: error))") {
        //                value = "\(String(describing: error))"
        //            }
        //            Button("Nil Error", role: .destructive) {
        //                error = nil
        //            }
        //        }
        #if SKIP
        if titleDialogIsPresented {
            ComposeView { context in
                androidx.compose.material3.AlertDialog(
                    onDismissRequest: { titleDialogIsPresented = false },
                    modifier: context.modifier,
                    confirmButton: {
                        androidx.compose.material3.TextButton(modifier: androidx.compose.ui.Modifier.logLayoutModifier(tag: "AlertDialogTextButton"), onClick: { titleDialogIsPresented = false }) {
                            androidx.compose.material3.Text(modifier: androidx.compose.ui.Modifier.logLayoutModifier(tag: "AlertDialogTitleOKText"), text: "OK")
                        }
                    },
                    title: {
                        androidx.compose.material3.Text("Title")
                    }
                )
            }
            .composeModifier { $0.logLayout(tag: "AlertDialogTitle") }
        }
        if titleMessageDialogIsPresented {
            ComposeView { _ in
                androidx.compose.material3.AlertDialog(
                    onDismissRequest: { titleMessageDialogIsPresented = false },
                    confirmButton: {
                        androidx.compose.material3.TextButton(onClick: { titleMessageDialogIsPresented = false }) {
                            androidx.compose.material3.Text(modifier: androidx.compose.ui.Modifier.logLayoutModifier(tag: "AlertDialogTitleMessageOKText"), text: "OK")
                        }
                    },
                    title: {
                        androidx.compose.material3.Text("Title + Message")
                    },
                    text: {
                        let messageColor = androidx.compose.material3.LocalContentColor.current
                        androidx.compose.runtime.SideEffect {
                            android.util.Log.d("AlertDialogMessageColor", "color=\(messageColor)")
                        }
                        androidx.compose.material3.Text(modifier: androidx.compose.ui.Modifier.logLayoutModifier(tag: "AlertDialogTitleMessageText"), text: "This is the alert message to show beneath the title")
                    }
                )
            }
        }
        if longMessageDialogIsPresented {
            ComposeView { _ in
                androidx.compose.material3.AlertDialog(
                    onDismissRequest: { longMessageDialogIsPresented = false },
                    confirmButton: {
                        androidx.compose.material3.TextButton(onClick: { longMessageDialogIsPresented = false }) {
                            androidx.compose.material3.Text(modifier: androidx.compose.ui.Modifier.logLayoutModifier(tag: "AlertDialogLongMessageOKText"), text: "OK")
                        }
                    },
                    title: {
                        androidx.compose.material3.Text("Long Message")
                    },
                    text: {
                        androidx.compose.material3.Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed commodo consectetur odio. Proin tempus orci ut tortor tincidunt elementum. Morbi finibus neque eget ullamcorper convallis. Suspendisse metus est, rhoncus vitae commodo non, ultricies ac leo. Proin scelerisque eros sed dolor dignissim accumsan id a nulla. Nulla tempor consequat nulla vel consequat. Etiam congue pretium sagittis. Quisque quis commodo velit, ac cursus massa. Aenean commodo congue velit in vestibulum. Proin viverra orci efficitur faucibus aliquet. Ut dignissim justo at dolor placerat, venenatis pulvinar dui consectetur. Nunc eget diam nec eros finibus finibus. Mauris et risus sit amet diam sagittis dapibus eu ac odio. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed commodo consectetur odio. Proin tempus orci ut tortor tincidunt elementum. Morbi finibus neque eget ullamcorper convallis. Suspendisse metus est, rhoncus vitae commodo non, ultricies ac leo. Proin scelerisque eros sed dolor dignissim accumsan id a nulla. Nulla tempor consequat nulla vel consequat. Etiam congue pretium sagittis. Quisque quis commodo velit, ac cursus massa. Aenean commodo congue velit in vestibulum. Proin viverra orci efficitur faucibus aliquet. Ut dignissim justo at dolor placerat, venenatis pulvinar dui consectetur. Nunc eget diam nec eros finibus finibus. Mauris et risus sit amet diam sagittis dapibus eu ac odio. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed commodo consectetur odio. Proin tempus orci ut tortor tincidunt elementum. Morbi finibus neque eget ullamcorper convallis. Suspendisse metus est, rhoncus vitae commodo non, ultricies ac leo. Proin scelerisque eros sed dolor dignissim accumsan id a nulla. Nulla tempor consequat nulla vel consequat. Etiam congue pretium sagittis. Quisque quis commodo velit, ac cursus massa. Aenean commodo congue velit in vestibulum. Proin viverra orci efficitur faucibus aliquet. Ut dignissim justo at dolor placerat, venenatis pulvinar dui consectetur. Nunc eget diam nec eros finibus finibus. Mauris et risus sit amet diam sagittis dapibus eu ac odio.")
                    }
                )
            }
        }
        if longButtonTitlesDialogIsPresented {
            ComposeView { _ in
                androidx.compose.material3.AlertDialog(
                    onDismissRequest: { longButtonTitlesDialogIsPresented = false },
                    modifier: androidx.compose.ui.Modifier.logLayoutModifier(tag: "AlertDialogLongTitles"),
                    confirmButton: {
                        androidx.compose.material3.TextButton(
                            onClick: { longButtonTitlesDialogIsPresented = false },
                            colors: androidx.compose.material3.ButtonDefaults.textButtonColors(contentColor: androidx.compose.material3.MaterialTheme.colorScheme.error)
                        ) {
                            androidx.compose.material3.Text(modifier: androidx.compose.ui.Modifier.logLayoutModifier(tag: "AlertDialogLongTitlesDestructiveText"), text: "Long destructive button text")
                        }
                    },
                    dismissButton: {
                        androidx.compose.material3.TextButton(onClick: { longButtonTitlesDialogIsPresented = false }) {
                            androidx.compose.material3.Text(modifier: androidx.compose.ui.Modifier.logLayoutModifier(tag: "AlertDialogLongTitlesCancelText"), text: "Long cancel button text")
                        }
                    },
                    title: {
                        androidx.compose.material3.Text("Alert Title?")
                    },
                    text: {
                        androidx.compose.material3.Text("Long message body for the alert which is displayed in skip")
                    }
                )
            }
        }
        if twoButtonsDialogIsPresented {
            ComposeView { _ in
                androidx.compose.material3.AlertDialog(
                    onDismissRequest: { twoButtonsDialogIsPresented = false },
                    confirmButton: {
                        androidx.compose.material3.TextButton(onClick: { twoButtonsDialogIsPresented = false; value = "Option" }) {
                            androidx.compose.material3.Text(modifier: androidx.compose.ui.Modifier.logLayoutModifier(tag: "AlertDialogTwoButtonsOptionText"), text: "Option")
                        }
                    },
                    dismissButton: {
                        androidx.compose.material3.TextButton(onClick: { twoButtonsDialogIsPresented = false; value = "Custom Cancel" }) {
                            androidx.compose.material3.Text(modifier: androidx.compose.ui.Modifier.logLayoutModifier(tag: "AlertDialogTwoButtonsCancelText"), text: "Cancel")
                        }
                    },
                    title: {
                        androidx.compose.material3.Text("Two Buttons")
                    }
                )
            }
        }
        #endif
    }
}

enum AlertPlaygroundError: LocalizedError {
    case testError
}

struct AlertCancelButton : View {
    @Binding var value: String

    var body: some View {
        Button("Cancel", role: .cancel) {
            value = "Custom Cancel"
        }
    }
}

struct AlertDestructiveButton : View {
    @Binding var value: String

    var body: some View {
        Button("Destructive", role: .destructive) {
            value = "Destructive"
        }
    }
}
