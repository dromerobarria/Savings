import Foundation

final class FetchInfoListUseCase {

    private let infoRepository: InfoRepository

    init(infoRepository: InfoRepository) {
        self.infoRepository = infoRepository
    }

    func execute() async throws -> [PromoModel] {
        let info = try await infoRepository.getInfoList()
        return info
    }
}

