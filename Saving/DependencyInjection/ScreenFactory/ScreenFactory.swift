//
//  ScreenFactory.swift
//  ConciertosChile
//
//  Created by Daniel Romero on 30-01-24.
//

import SwiftUI
import SwiftData

final class ScreenFactory: HomeCoordinatorFactory,
                           FavoritesCoordinatorFactory {
    
    
    private var modelContext: ModelContext
    private let appFactory: AppFactory

    init(appFactory: AppFactory, modelContext: ModelContext) {
        self.appFactory = appFactory
        self.modelContext = modelContext
    }
}

// MARK: - EventViewFactory

extension ScreenFactory: HomeViewFactory {
    func makeHomeView(coordinator: HomeCoordinatorProtocol) -> HomeView {
        let view = HomeView(modelContext: modelContext)
        return view
    }
}


// MARK: - FavouriteViewFactory

extension ScreenFactory: FavoritesViewFactory {
    func makeFavoritesView(coordinator: FavoritesCoordinatorProtocol) -> FavoritesView {
        let view = FavoritesView(modelContext: modelContext)
        return view
    }
}

// MARK: - MovieDetailsFactory
//
//extension ScreenFactory: HomeDetailsViewFactory, FavoritesDetailsViewFactory {
//    func makeEventDetailsView(pet: PromoModel) -> DetailEventView {
//        let view = DetailEventView()
//        return view
//    }
//    
//    func makeCalendarDetailsView(event: EventModel) -> DetailEventView {
//        let view = DetailEventView()
//        return view
//    }
//}
