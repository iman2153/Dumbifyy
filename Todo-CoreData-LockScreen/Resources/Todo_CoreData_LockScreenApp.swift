import SwiftUI
import RevenueCat
import RevenueCatUI

@main
struct Todo_CoreData_LockScreenApp: App {
    @StateObject private var subscriptionManager = SubscriptionManager()
    
    init() {
        Purchases.configure(withAPIKey: "appl_TYitkunNHvNCYTLSXadiDOeYSkK")
        
        #if DEBUG
        Purchases.logLevel = .debug
        #endif
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(subscriptionManager)
        }
    }
}

class SubscriptionManager: ObservableObject {
    @Published var isProMember = false
    
    func updateSubscriptionStatus() async {
        do {
            let customerInfo = try await Purchases.shared.customerInfo()
            DispatchQueue.main.async {
                self.isProMember = customerInfo.entitlements["pro"]?.isActive == true
            }
        } catch {
            print("Error fetching subscription status: \(error)")
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var subscriptionManager: SubscriptionManager
    
    var body: some View {
        WidgetDeepLinkHandler()
            .presentPaywallIfNeeded(
                requiredEntitlementIdentifier: "pro",
                purchaseCompleted: { customerInfo in
                    print("Purchase completed: \(customerInfo.entitlements)")
                    Task {
                        await subscriptionManager.updateSubscriptionStatus()
                    }
                },
                restoreCompleted: { customerInfo in
                    print("Purchases restored: \(customerInfo.entitlements)")
                    Task {
                        await subscriptionManager.updateSubscriptionStatus()
                    }
                }
            )
            .task {
                await subscriptionManager.updateSubscriptionStatus()
            }
    }
}
