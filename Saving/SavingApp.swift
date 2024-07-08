import SwiftUI
import SwiftData

@main
struct SavingApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            PromoModel.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(
                screenFactory: ScreenFactory(appFactory: AppFactory(modelContext: sharedModelContainer.mainContext), modelContext: sharedModelContainer.mainContext),
                coordinator: AppCoordinator()
            )
            .onAppear {
                NetworkMonitor.shared.startMonitoring()
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
