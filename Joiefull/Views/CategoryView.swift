//
//  CategoryView.swift
//  Joiefull
//
//  Created by Thibault Giraudon on 07/07/2025.
//

import SwiftUI

struct CategoryView: View {
    var title: String
    var clothes: [Cloth]

    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var viewModel: ClothesViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title.bold())

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(clothes, id: \.self) { cloth in
                        Group {
                            if horizontalSizeClass == .compact {
                                NavigationLink {
                                    ClothDetailsView(cloth: cloth)
                                } label: {
                                    ClothView(cloth: cloth)
                                        .foregroundStyle(.black)
                                }
                            } else {
                                ClothView(cloth: cloth)
                                    .onTapGesture {
                                        viewModel.selectedCloth = cloth
                                    }
                            }
                        }
                            .accessibilityElement(children: .contain)
                            .accessibilityLabel("Voir les détails de \(cloth.name)")
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
    let clothes = DefaultData().clothes
    
    NavigationStack {
        CategoryView(title: "Hauts", clothes: clothes)
            .environmentObject(viewModel)
            .onAppear {
                Task {
                    await viewModel.fetchClothes()
                }
            }
    }
}
