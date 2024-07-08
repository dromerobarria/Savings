enum EventViewEvent {
    case onAppear
}

enum FavoriteViewState: Equatable {
    case idle
    case loading
    case error(String)
    case loaded(ViewData)
    
    struct ViewData: Equatable {
        var infoItems: [PromoModel]
    }
}
