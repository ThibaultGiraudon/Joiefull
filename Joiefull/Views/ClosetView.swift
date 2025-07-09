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
    @AccessibilityFocusState private var isFocused: Bool
    
    @State private var detailViewWidth: CGFloat = UIScreen.main.bounds.width * 0.5
    
    private let minWidth = UIScreen.main.bounds.width * 0.4
    private let maxWidth = UIScreen.main.bounds.width * 0.8
    var body: some View {
        HStack {
            ScrollView(showsIndicators: false) {
                CategoryView(title: "Hauts", filter: .top)
                    .accessibilityLabel("Catégorie : Hauts")
                CategoryView(title: "Bas", filter: .bottoms)
                    .accessibilityLabel("Catégorie : Bas")
                CategoryView(title: "Sacs", filter: .accessories)
                    .accessibilityLabel("Catégorie : Sacs")
                CategoryView(title: "Chaussure", filter: .shoes)
                    .accessibilityLabel("Catégorie : Chaussures")
            }
            .accessibilityLabel("Liste des catégories de vêtements. Tirez vers le bas pour rafraîchir.")
            .refreshable {
                Task {
                    await viewModel.fetchClothes() 
                }
            }
            if let cloth = viewModel.selectedCloth, horizontalSizeClass == .regular {
                ZStack {
                    Rectangle()
                        .ignoresSafeArea()
                    RoundedRectangle(cornerRadius: 3)
                        .fill(.gray)
                        .frame(width: 6, height: 50)
                }
                .frame(width: 15)
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                let newWidth = detailViewWidth - value.translation.width
                                detailViewWidth = min(max(newWidth, minWidth), maxWidth)
                            })
                    )
                ClothDetailsView(cloth: cloth)
                    .frame(width: detailViewWidth)
                    .accessibilityElement(children: .contain)
                    .accessibilityLabel("Détails du vêtement sélectionné : \(cloth.wrappedValue.name)")
                    .accessibilityFocused($isFocused)
                    .onAppear {
                        isFocused = true
                    }
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
