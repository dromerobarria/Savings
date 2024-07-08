//
//  EventCoordinator.swift
//  ConciertosChile
//
//  Created by Daniel Romero on 30-01-24.
//

import Foundation

final class HomeCoordinator: Coordinator {
    
    enum Screen: Routable {
        case PromoDetails(PromoModel)
    }
    
    @Published var navigationPath = [Screen]()
    
    init() {}
}

extension HomeCoordinator: HomeCoordinatorProtocol {
    func PromoDetails(_ promo: PromoModel) {
        navigationPath.append(.PromoDetails(promo))
    }
}

