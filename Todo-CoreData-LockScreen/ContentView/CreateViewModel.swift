// //
// //  CreateViewModel.swift
// //  Todo-CoreData-LockScreen
// //
// //  Created by Iman Morshed on 11/16/24.
// //

// import Foundation
// import CoreData
// import SwiftUI

// final class CreateViewModel: ObservableObject {
//     @Published var userInput = ""
//     @Published var appList: [AppEntity] = []

//     init() {
//         getAllApps()
//     }

//     // MARK: - View Interaction Functions
//     func didSubmitTextField() {
//         if !userInput.isEmpty {
//             Task {
//                 await createApp()
//                 clearUserInput()
//                 getAllApps()
//             }
//         }
//     }

//     func didTapApp(app: AppEntity) {
//         Task {
//             await editApp(app: app)
//             getAllApps()
//         }
//     }

//     func didSwipeApp(app: AppEntity) {
//         Task {
//             await deleteApp(app: app)
//             getAllApps()
//         }
//     }

//     func didMoveApp(from source: IndexSet, to destination: Int) {
//         appList.move(fromOffsets: source, toOffset: destination)
//         Task {
//             await updateAppPositions()
//         }
//     }

//     func didTapXButton() {
//         clearUserInput()
//     }
// }

// private extension CreateViewModel {
//     func getAllApps() {
//         let response = CoreDataManager.shared.getAllApps()
//         DispatchQueue.main.async { [weak self] in
//             guard let self = self else { return }
//             self.appList = response
//         }
//     }

//     func createApp() async {
//         CoreDataManager.shared.createApp(title: userInput)
//     }

//     func editApp(app: AppEntity) async {
//         CoreDataManager.shared.editApp(app: app)
//     }

//     func deleteApp(app: AppEntity) async {
//         CoreDataManager.shared.deleteApp(app: app)
//     }

//     func updateAppPositions() async {
//         CoreDataManager.shared.updateAppPositions(apps: appList)
//     }

//     func clearUserInput() {
//         DispatchQueue.main.async { [weak self] in
//             guard let self = self else { return }
//             self.userInput = ""
//         }
//     }
// }