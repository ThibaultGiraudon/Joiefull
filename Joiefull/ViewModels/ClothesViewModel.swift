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
    @Published var searchText = ""
    var filteredClothes: [Cloth] {
        get {
            return self.clothes.filter {
                searchText.isEmpty || $0.name.capitalized.contains(searchText.capitalized)
            }
        }
        set {
            
        }
    }
    
    var selectedCloth: Binding<Cloth>? {
        guard let id = self.selectedClothID, let index = self.clothes.firstIndex(where: { $0.id == id }) else {
            return nil
        }
        return Binding(
            get: { self.clothes[index]},
            set: { self.clothes[index] = $0}
        )

    }
    
    var session: URLSessionInterface
    
    init(session: URLSessionInterface = URLSession.shared) {
        self.session = session
        Task {
            await self.fetchClothes()
        }
    }
    
    @MainActor
    func fetchClothes() async {
        errorMessage = ""
        showError = false

        do {
            clothes = try await API(session: session).call()
        } catch let apiError as APIError {
            switch apiError {
            case .invalidResponse:
                errorMessage = "Réponse du serveur invalide."
            case .invalidStatusCode(let code):
                errorMessage = "Erreur serveur (code \(code))."
            case .decodingError:
                errorMessage = "Erreur de format des données."
            case .networkError(let underlyingError):
                if let urlError = underlyingError as? URLError {
                    switch urlError.code {
                    case .notConnectedToInternet, .timedOut, .networkConnectionLost:
                        errorMessage = "Problème de connexion internet."
                    default:
                        errorMessage = "Erreur réseau : \(urlError.localizedDescription)"
                    }
                } else {
                    errorMessage = "Erreur réseau inattendue."
                }
            }
            showError = true
        } catch {
            errorMessage = "Une erreur inconnue est survenue."
            showError = true
        }
    }
    
    func indices(for category: Cloth.Category) -> [Int] {
        filteredClothes.indices.filter { filteredClothes[$0].categoryItem == category }
    }
}
