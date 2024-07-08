//
//  FavouriteCoordinator.swift
//  ConciertosChile
//
//  Created by Daniel Romero on 30-01-24.
//

import Foundation

final class FavoritesCoordinator: Coordinator {
    
    enum Screen: Routable {
        case EventDetails(PromoModel)
    }
    
    @Published var navigationPath = [Screen]()
    
    init() {}
}

extension FavoritesCoordinator: FavoritesCoordinatorProtocol {
    func EventDetails(_ event: PromoModel) {
        navigationPath.append(.EventDetails(event))
    }
}

