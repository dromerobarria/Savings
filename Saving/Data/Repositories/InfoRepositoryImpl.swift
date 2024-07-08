import Foundation
import SwiftUI
import SwiftData

final class InfoRepositoryImplementation: @unchecked Sendable {
    var modelContext: ModelContext? = nil
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
}

extension InfoRepositoryImplementation: InfoRepository {
   
    func getInfoList() async throws -> [PromoModel] {
        guard NetworkMonitor.shared.isConnected else { throw NetworkError.noConnect }
        let fetchDescriptor = FetchDescriptor<PromoModel>()
        
        do {
            let info = try modelContext?.fetch(fetchDescriptor) ?? []
            return info
        } catch {
            return []
        }
    }
}
