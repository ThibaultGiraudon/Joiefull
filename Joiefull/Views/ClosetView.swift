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
        VStack {
            HStack {
                VStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Rechercher", text: $viewModel.searchText)
                            .foregroundStyle(.black)
                        Spacer()
                        if !viewModel.searchText.isEmpty {
                            Image(systemName: "xmark.circle")
                                .onTapGesture {
                                    viewModel.searchText = ""
                                }
                        }
                    }
                    .foregroundStyle(.gray)
                    .padding(5)
                    .background {
                        Capsule()
                            .fill(.gray.opacity(0.2))
                    }
                    .padding()
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel("Bar de recherche pour filtrer les vêtement")
                    ScrollView(showsIndicators: false) {
                        ForEach(viewModel.mappedClothes, id: \.0) { category, clothes in
                            CategoryView(title: category, clothes: clothes)
                        }
                    }
                    .refreshable {
                        Task {
                            await viewModel.fetchClothes()
                        }
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
                                if newWidth < 50 {
                                    viewModel.selectedCloth = nil
                                }
                            })
                    )
                    ClothDetailsView(cloth: cloth)
                        .id(cloth.id)
                        .frame(width: detailViewWidth)
                        .accessibilityElement(children: .contain)
                        .accessibilityLabel("Détails du vêtement sélectionné : \(cloth.name)")
                        .accessibilityFocused($isFocused)
                        .onAppear {
                            isFocused = true
                        }
                }
            }
        }
    }
}

#Preview {
    @Previewable @StateObject var viewModel = ClothesViewModel()
    
    NavigationStack {
        ClosetView()
            .environmentObject(viewModel)
    }
}
