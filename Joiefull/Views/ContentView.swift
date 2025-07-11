//
//  ContentView.swift
//  Joiefull
//
//  Created by Thibault Giraudon on 07/07/2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ClothesViewModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        NavigationStack {
            ClosetView()
            .overlay(alignment: .bottom) {
                if viewModel.showError {
                    Group {
                        Color.red
                        Text(viewModel.errorMessage)
                            .accessibilityLabel("Erreur : \(viewModel.errorMessage)")
                            .accessibilityAddTraits(.isStaticText)
                    }
                    .frame(height: 40)
                    .accessibilityElement(children: .combine)
                    .accessibilityAddTraits(.isHeader)
                }
            }
        }
        .dynamicTypeSize(.xSmall ... .accessibility3)
    }
}

#Preview() {
    @Previewable @StateObject var viewModel = ClothesViewModel()
    
    ContentView()
        .environmentObject(viewModel)
}
