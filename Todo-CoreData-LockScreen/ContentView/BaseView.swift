//
//  BaseView.swift
//  Todo-CoreData-LockScreen
//
//  Created by Iman Morshed on 11/16/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        Text("Home View")
    }
}


struct SettingsView: View {
    var body: some View {
        Text("Settings View")
    }
}
struct BaseView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)
            
            CreateView()
                .tabItem {
                    Label("Create", systemImage: "plus.circle")
                }
                .tag(1)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(2)
        }
    }
}
