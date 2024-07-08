import Foundation

final class HomeViewModel: ViewModel {
    @Published private(set) var state: HomeViewState
    private let fetchInfoListUseCase: FetchInfoListUseCase
   
    init(
        fetchInfoListUseCase: FetchInfoListUseCase
    ) {
        state = .idle
        self.fetchInfoListUseCase = fetchInfoListUseCase
    }

    func handle(_ event: HomeViewEvent) {
        switch event {
        case .onAppear:
            Task { await retrieveInfo() }
        }
    }
}

private extension HomeViewModel {

    func fetchInfo() async throws -> HomeViewState.ViewData {
        let info = try await fetchInfoListUseCase.execute()
        return .init(infoItems: info)
    }

    func retrieveInfo() async {
        do {
            let info = try await fetchInfo()
            state = .loaded(info)
        } catch {
            state = .error("\(error.localizedDescription)")
        }
    }
    
}
