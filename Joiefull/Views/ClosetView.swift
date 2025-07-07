//
//  ClosetView.swift
//  Joiefull
//
//  Created by Thibault Giraudon on 07/07/2025.
//

import SwiftUI

struct ClosetView: View {
    @EnvironmentObject var viewModel: ClothesViewModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        HStack {
            ScrollView(showsIndicators: false) {
                CategoryView(title: "Hauts", clothes: viewModel.clothes, filter: .top)
                CategoryView(title: "Bas", clothes: viewModel.clothes, filter: .bottoms)
                CategoryView(title: "Sacs", clothes: viewModel.clothes, filter: .accessories)
                CategoryView(title: "Chaussure", clothes: viewModel.clothes, filter: .shoes)
            }
            .refreshable {
                Task {
                    await viewModel.fetchClothes() 
                }
            }
            if let cloth = viewModel.selectedCloth, horizontalSizeClass == .regular {
                ClothDetailsView(cloth: cloth)
                    .frame(width: UIScreen.main.bounds.width * 0.4)
            }
        }
    }
}

#Preview {
    @Previewable @StateObject var viewModel = ClothesViewModel()
    @Previewable @StateObject var coordinator = AppCoordinator()
    
    ClosetView()
        .environmentObject(coordinator)
        .environmentObject(viewModel)
}
