//
//  FavouriteCoordinatorView.swift
//  ConciertosChile
//
//  Created by Daniel Romero on 30-01-24.
//

import SwiftUI

struct FavoritesCoordinatorView: View {

    private let factory: FavoritesViewFactory
    @ObservedObject private var coordinator: FavoritesCoordinator

    init(_ coordinator: FavoritesCoordinator, factory: FavoritesViewFactory) {
        self.factory = factory
        self.coordinator = coordinator
    }

    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            factory.makeFavoritesView(coordinator: coordinator)
                .navigationDestination(for: FavoritesCoordinator.Screen.self) {
                    destination($0)
                }
        }
    }

    @ViewBuilder
    private func destination(_ screen: FavoritesCoordinator.Screen) -> some View {
       
    }
}
