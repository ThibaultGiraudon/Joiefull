//
//  AppCoordinator.swift
//  Joiefull
//
//  Created by Thibault Giraudon on 07/07/2025.
//

import Foundation

class AppCoordinator: ObservableObject {
    @Published var path: [AppRoute] = []
    
    func goToDetail(cloth: Cloth) {
        path.append(.detailView(cloth: cloth))
    }
    
    func resetNavigation() {
        path = []
    }
}

enum AppRoute: Hashable {
    case home
    case detailView(cloth: Cloth)
}
