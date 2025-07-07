//
//  ContentView.swift
//  Joiefull
//
//  Created by Thibault Giraudon on 07/07/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ClothesViewModel()
    var body: some View {
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
        .onAppear {
            Task {
                await viewModel.fetchClothes()
            }
        }
        .overlay(alignment: .bottom) {
            if viewModel.showError {
                Group {
                    Color.red
                    Text(viewModel.errorMessage)
                }
                .frame(height: 40)
            }
        }
    }
}

#Preview() {
    ContentView()
}

