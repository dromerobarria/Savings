//
//  FavouriteCoordinatorProtocol.swift
//  ConciertosChile
//
//  Created by Daniel Romero on 30-01-24.
//

import Foundation

@MainActor
protocol FavoritesCoordinatorProtocol {
    func EventDetails(_ event: PromoModel)
}

