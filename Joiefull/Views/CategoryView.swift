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


    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title.bold())

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.indices(for: filter), id: \.self) { index in
                        Group {
                            if horizontalSizeClass == .compact {
                                NavigationLink {
                                    ClothDetailsView(cloth: $viewModel.clothes[index])
                                } label: {
                                    ClothView(cloth: $viewModel.clothes[index])
                                        .foregroundStyle(.black)
                                }

                            } else {
                                ClothView(cloth: $viewModel.clothes[index])
                                    .onTapGesture {
                                        
                                        viewModel.selectedClothID =
                                        viewModel.selectedClothID == $viewModel.clothes[index].id
                                        ? nil
                                        : $viewModel.clothes[index].id
                                    }
                            }
                        }
                            .accessibilityElement(children: .contain)
                            .accessibilityLabel("Voir les détails de \(viewModel.clothes[index].name)")
                            .accessibilityHint("Double-tape pour ouvir la fiche produit")
                    }
                }
            }
        }
        .padding()
    }
}


#Preview {
    @Previewable @StateObject var viewModel = ClothesViewModel()
    @Previewable @StateObject var coordinator = AppCoordinator()
    @Previewable @State var clothes = DefaultData().clothes
    
    NavigationStack {
        CategoryView(title: "Hauts", filter: .top)
            .environmentObject(coordinator)
            .environmentObject(viewModel)
            .onAppear {
                Task {
                    await viewModel.fetchClothes()
                }
            }
    }
}
