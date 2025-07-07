//
//  ClothesViewModel.swift
//  Joiefull
//
//  Created by Thibault Giraudon on 07/07/2025.
//

import Foundation

class ClothesViewModel: ObservableObject {
    @Published var clothes: [Cloth] = .init()
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    static var shared = ClothesViewModel()
    
    init() {
        Task {
            await self.fetchClothes()
        }
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
}
