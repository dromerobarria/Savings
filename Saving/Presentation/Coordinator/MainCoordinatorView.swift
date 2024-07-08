//
//  MainCoordinatorView.swift
//  ConciertosChile
//
//  Created by Daniel Romero on 30-01-24.
//

import SwiftUI

struct MainCoordinatorView: View {
    
    enum Tab {
        case home
        case favorites
    }

    @State private var selectedTab = Tab.home
    @Environment(\.colorScheme) var colorScheme
    
    private let factory: ScreenFactory
    private let homeCoordinator: HomeCoordinator
    private let favoritesCoordinator: FavoritesCoordinator

    init(factory: ScreenFactory) {
        self.factory = factory

        homeCoordinator = .init()
        favoritesCoordinator = .init()
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeCoordinatorView(homeCoordinator, factory: factory)
                .tabItem {
                    Label("Promos", systemImage: Constants.home)
                }
                .tag(Tab.home)
            
            FavoritesCoordinatorView(favoritesCoordinator, factory: factory)
                .tabItem {
                    Label("Favoritos", systemImage: Constants.favorites)
                }
                .tag(Tab.favorites)
        }
        .tint(.appAccent)
        .onAppear {
            setupTabBar()
        }
    }

    private enum Constants {
        static let home = "menucard"
        static let favorites = "list.star"
    }

    @MainActor private func setupTabBar() {
        UITabBar.appearance().tintColor = UIColor(resource: .appAccent)
        UITabBar.appearance().isTranslucent = true

        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = colorScheme == .dark ? .black : .white

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = UITabBar.appearance().standardAppearance
    }
}
