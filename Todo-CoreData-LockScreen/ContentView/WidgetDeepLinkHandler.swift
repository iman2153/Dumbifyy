import SwiftUI

struct WidgetDeepLinkHandler: View {
    @State private var shouldShowEmptyView = false
    
    var body: some View {
        Group {
            if shouldShowEmptyView {
                
                EmptyView()
                
                    .onTapGesture {
                        
                    }
            } else {
                MainView()
            }
        }
        .onOpenURL { url in
            handleURL(url)
        }
    }
    
    private func handleURL(_ url: URL) {
        guard url.scheme == "stupid" else {
            return
        }
        
        if url.host == "todo" {
            shouldShowEmptyView = true
            if url.pathComponents.count > 1 {
                let appName = url.pathComponents[1]
                openApp(appName)
            }
        } else {
            shouldShowEmptyView = false
            
        }
    }
    
    private func openApp(_ appName: String) {
        let urlString = getURLString(for: appName)
        if let appURL = URL(string: urlString) {
            UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
        }
    }
    
    private func getURLString(for appName: String) -> String {
        return AppLinks[appName] ?? ""
    }

}
