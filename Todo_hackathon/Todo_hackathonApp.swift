import SwiftUI

@main
struct TodayTasksApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
