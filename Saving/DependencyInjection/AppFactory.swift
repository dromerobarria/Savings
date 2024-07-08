import Foundation
import SwiftData

final class AppFactory {
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    private lazy var InfoRepository:InfoRepositoryImplementation = {
        return InfoRepositoryImplementation(modelContext: modelContext)
    }()
}

// MARK: - Event

extension AppFactory {

    func makeFetchInfoUseCase() -> FetchInfoListUseCase {
        FetchInfoListUseCase(infoRepository: InfoRepository)
    }
}
