import Foundation

protocol InfoRepository {
    func getInfoList() async throws -> [PromoModel]
}
