import Foundation

final class FavoriteViewModel: ViewModel {
    @Published private(set) var state: FavoriteViewState
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

private extension FavoriteViewModel {

    func fetchInfo() async throws -> FavoriteViewState.ViewData {
        let info = try await fetchInfoListUseCase.execute().filter{$0.favorite == true}
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

