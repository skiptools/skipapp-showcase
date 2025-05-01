// Copyright 2023–2025 Skip
import SwiftUI

import Combine

// Has the user verified their email or not?
class VerifyEmailManager: ObservableObject {
     static let shared = VerifyEmailManager()
     private init() {}
     
     @Published var isVerified = false
}

// Have they made an account?
class AccountManager: ObservableObject {
     static let shared = AccountManager()
     private init() {}
     
     @Published var account: String? = nil
}

class NavManager: ObservableObject {
    static let shared = NavManager()
    private init() {
        subscribeToRouteChanges()
    }
    
    @Published var path: [Path] = []
    
    enum Path {
        case createAccount
        case onboarded
    }
    
    private var subscribers: Set<AnyCancellable> = []
    func subscribeToRouteChanges() {
        #if !SKIP
        Publishers.CombineLatest(
            VerifyEmailManager.shared.$isVerified.setFailureType(to: Error.self).eraseToAnyPublisher(),
            AccountManager.shared.$account.setFailureType(to: Error.self).eraseToAnyPublisher()
        )
        .debounce(for: 0.3, scheduler: DispatchQueue.main) // Debounce so we don't jump through a bunch of screens if we quickly log out or set up a bunch of values in the CombineLatest at the same time.
        .sink(receiveCompletion: { error in
            print("error \(error)")
        }, receiveValue: { (isVerified, account) in
            print("New route: isVerified: \(isVerified) account: \(account)")
            
            if !isVerified {
                print("set to verify")
                self.path = []
                return
            }
            
            if account == nil {
                print("set to create account")
                self.path = [.createAccount]
                return
            }
            
            self.path = [.createAccount, .onboarded]
        })
        .store(in: &subscribers)
        #endif
    }
}

struct CombineLatestPlayground: View {
    @ObservedObject var navManager = NavManager.shared

    var body: some View {
        NavigationStack(path: $navManager.path) {
            VStack {
                Text("Email verified: \(VerifyEmailManager.shared.isVerified)")
                Button("Verify") {
                    VerifyEmailManager.shared.isVerified = true
                }
            }
                .navigationDestination(for: NavManager.Path.self) { route in
                    switch route {
                    case .createAccount:
                        Text("Email verified: \(VerifyEmailManager.shared.isVerified)")
                        Button("Create account") {
                            AccountManager.shared.account = "Tom Cruise"
                        }
                    case .onboarded:
                        VStack {
                            Text("Verified: \(VerifyEmailManager.shared.isVerified) as \(AccountManager.shared.account ?? "")")
                            Button("Log out") {
                                AccountManager.shared.account = nil
                                VerifyEmailManager.shared.isVerified = false
                            }
                        }
                    }
                }
        }
    }
}
