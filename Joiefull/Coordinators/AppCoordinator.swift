//
//  AppCoordinator.swift
//  Joiefull
//
//  Created by Thibault Giraudon on 07/07/2025.
//

import Foundation
import SwiftUI

class AppCoordinator: ObservableObject {
    @Published var path: [AppRoute] = []
    
    
    func goToDetail() {
        path.append(.detailView)
    }
    
    func resetNavigation() {
        path = []
    }
}

enum AppRoute: Hashable {
    case home
    case detailView
}
