//
//  ClothesViewModel.swift
//  Joiefull
//
//  Created by Thibault Giraudon on 07/07/2025.
//

import Foundation
import SwiftUI

class ClothesViewModel: ObservableObject {
    @Published var clothes: [Cloth] = .init()
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    @Published var selectedClothID: Int?
    
    var selectedCloth: Binding<Cloth>? {
        guard let id = self.selectedClothID, let index = self.clothes.firstIndex(where: { $0.id == id }) else {
            return nil
        }
        return Binding(
            get: { self.clothes[index]},
            set: { self.clothes[index] = $0}
        )

    }
    
    @MainActor
    func fetchClothes() async {
        do {
            errorMessage = ""
            showError = false
            clothes = try await API().call()
        } catch {
            if let urlError = error as? URLError {
                switch urlError.code {
                    case .timedOut, .notConnectedToInternet, .networkConnectionLost:
                        errorMessage = "Connexion impossible..."
                        showError = true
                    default:
                        errorMessage = "Une erreur est survenu"
                        showError = true
                }
            } else {
                errorMessage = "Une erreur est survenu"
                showError = true
            }
        }
    }
    
    func indices(for category: Cloth.Category) -> [Int] {
        clothes.indices.filter { clothes[$0].categoryItem == category }
    }
}
