//
//  WelcomSheet.swift
//  Todo-CoreData-LockScreen
//
//  Created by Iman Morshed on 12/6/24.
//

import SwiftUI

struct WelcomeSheet: View {
    @State private var showWelcomeSheet = true

    var body: some View {
        VStack {
            // Your main content here
            Text("Main Content")
        }
        .sheet(isPresented: $showWelcomeSheet) {
            VStack {
                Text("Welcome to the App!")
                    .font(.largeTitle)
                    .padding()

                Text("Dumb Phone helps you take back control of your phone by removing all app icons")
                    .padding()

                Button(action: {
                    showWelcomeSheet = false
                }) {
                    Text("Got it!")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding()
        }
    }
}

#Preview {
    WelcomeSheet()
}
