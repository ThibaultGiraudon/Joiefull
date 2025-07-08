//
//  ContentView.swift
//  Joiefull
//
//  Created by Thibault Giraudon on 07/07/2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ClothesViewModel
    @EnvironmentObject var coordinator: AppCoordinator
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            ClosetView()
            .overlay(alignment: .bottom) {
                if viewModel.showError {
                    Group {
                        Color.red
                        Text(viewModel.errorMessage)
                    }
                    .frame(height: 40)
                }
            }
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                    case .detailView:
                        if let cloth = viewModel.selectedCloth {
                            ClothDetailsView(cloth: cloth)
                        }
                    default:
                        EmptyView()
                }
            }
        }
    }
}

#Preview() {
    @Previewable @StateObject var viewModel = ClothesViewModel()
    @Previewable @StateObject var coordinator = AppCoordinator()
    
    ContentView()
        .environmentObject(coordinator)
        .environmentObject(viewModel)
}

