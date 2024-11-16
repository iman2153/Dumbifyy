//
//  ContentView.swift
//  Todo-CoreData-LockScreen
//
//  Created by Kim Insub on 2022/10/11.
//

import SwiftUI
import WidgetKit

struct MainView: View {
    @Environment(\.scenePhase) var scenePhase
    @ObservedObject var viewModel = MainViewModel()
    var body: some View {
            List {
                addTodoSection
                inProgressTodoListSection
                doneTodoListSection
            }
            .onChange(of: scenePhase, perform: { newValue in
                WidgetCenter.shared.reloadAllTimelines()
            })
            .onOpenURL { url in
                print(url)
                handleURL(url)
            }
            .background(Color.black)
            .listStyle(GroupedListStyle())
            .environment(\.colorScheme, .dark)
        }
    private func handleURL(_ url: URL) {
        guard url.scheme == "todo" else {
            return
        }
        
        if url.host == "todo" {
            if url.pathComponents.count > 1 {
                let appName = url.pathComponents[1]
                openApp(appName)
            }
        } else {
           print("fail")
        }
        
    }
    
    private func openApp(_ appName: String) {
        let urlString = getURLString(for: appName)
        print(urlString)
        if let appURL = URL(string: urlString) {
            print("trying")
            UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
        }
    }
    
    private func getURLString(for appName: String) -> String {
        return AppLinks[appName] ?? ""
    }
}

private extension MainView {
   var addTodoSection: some View {
       Section("Add") {
           HStack {
               TextField("Enter", text: $viewModel.userInput) {
                   viewModel.didSubmitTextField()
               }
               Spacer()
               Image(systemName: "x.circle")
                   .onTapGesture {
                       viewModel.didTapXbutton()
                   }
                   .opacity(0.6)
                   .font(.subheadline)
           }
       }
   }

   var inProgressTodoListSection: some View {
       Section("Apps in the widget") {
           ForEach(viewModel.inProgressTodoList, id: \.self) { todo in
               HStack(spacing: 4) {
                   Button {
                       withAnimation {
                           viewModel.didTapTodo(todo: todo)
                       }
                   } label: {
                       Image(systemName: "square")
                           .font(.caption)
                   }
                   Text(todo.title ?? "")
               }
               .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                   Button {
                       withAnimation {
                           viewModel.didSwipeTodo(todo: todo)
                       }
                   } label: {
                       Image(systemName: "trash")
                   }
                   .tint(.red)
               }
           }
       }
   }
   var doneTodoListSection: some View {
       Section("Done") {
           ForEach(viewModel.doneTodoList, id: \.self) { todo in
               HStack(spacing: 4) {
                   Button {
                       withAnimation {
                           viewModel.didTapTodo(todo: todo)
                       }
                   } label: {
                       Image(systemName: "checkmark.square")
                           .font(.caption)
                   }
                   Text(todo.title ?? "")
                       .strikethrough()
               }

               .opacity(0.6)
               .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                   Button {
                       withAnimation {
                           viewModel.didSwipeTodo(todo: todo)
                       }
                   } label: {
                       Image(systemName: "trash")
                   }
                   .tint(.red)
               }
           }
       }
   }
}
