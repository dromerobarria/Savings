//
//  ScreenFactoryProtocols.swift
//  ConciertosChile
//
//  Created by Daniel Romero on 30-01-24.
//

import SwiftUI

@MainActor
protocol HomeViewFactory {
    func makeHomeView(coordinator: HomeCoordinatorProtocol) -> HomeView
}


@MainActor
protocol FavoritesViewFactory {
    func makeFavoritesView(coordinator: FavoritesCoordinatorProtocol) -> FavoritesView
}


//@MainActor
//protocol HomeDetailsViewFactory {
//    func makeEventDetailsView(
//        event: PromoModel
//    ) -> DetailEventView
//}
//
//
//@MainActor
//protocol FavoritesDetailsViewFactory {
//    func makeCalendarDetailsView(
//        event: PromoModel
//    ) -> DetailEventView
//}
