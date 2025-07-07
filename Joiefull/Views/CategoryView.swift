//
//  CategoryView.swift
//  Joiefull
//
//  Created by Thibault Giraudon on 07/07/2025.
//

import SwiftUI

struct CategoryView: View {
    var title: String
    var filter: Cloth.Category
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var coordinator: AppCoordinator
    @EnvironmentObject var viewModel: ClothesViewModel
    
    @State private var clothes: [Cloth] = []

    var size: CGSize {
        if horizontalSizeClass == .compact {
            return CGSize(width: 200, height: 200)
        }
        return CGSize(width: 221, height: 254)
    }
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title.bold())
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach($clothes) { $cloth in
                        ClothView(cloth: $cloth, size: size)
                            .onTapGesture {
                                if horizontalSizeClass == .compact {
                                    coordinator.goToDetail(cloth: cloth)
                                } else {
                                    viewModel.selectedCloth = cloth
                                }
                            }
                    }
                }
            }
        }
        .padding()
        .onAppear {
            Task {
                await viewModel.fetchClothes()
                clothes = viewModel.clothes.filter({ $0.categoryItem == filter })
            }
        }
    }
}

#Preview {
    @Previewable @StateObject var viewModel = ClothesViewModel()
    @Previewable @StateObject var coordinator = AppCoordinator()
    @Previewable @State var clothes = DefaultData().clothes
    
    CategoryView(title: "Hauts", filter: .top)
        .environmentObject(coordinator)
        .environmentObject(viewModel)
}
