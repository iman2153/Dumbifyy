import SwiftUI

struct HowToView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("1. Go to Create View screen to add your own apps you want on your phone")
            Text("2. Add the apps by searching for them")
            Text("3. Step three: Boilerplate text for step three.")

        }
        .padding()
    }
}

struct MainTabView: View {
    @Binding var tabNumber: Int

    var body: some View {
        TabView(selection: $tabNumber) {
            MainView()
                .tabItem {
                    Label("Create", systemImage: "plus.circle")
                }
                .tag(0)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
                .tag(1)
            
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    @State static var tabNumber = 0

    static var previews: some View {
        MainTabView(tabNumber: $tabNumber)
    }
}
