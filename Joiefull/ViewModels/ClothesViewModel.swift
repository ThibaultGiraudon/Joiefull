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
    @Published var images: [Int: (Image, String)] = [:]
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    @Published var selectedCloth: Cloth?
    @Published var searchText = ""
    var mappedClothes: [(String, [Cloth])] {
        return Dictionary(grouping: self.clothes) { cloth -> String in
            return cloth.category
        }.map { key, clothes in
            return (key, clothes.filter( { searchText.isEmpty || $0.name.lowercased().contains(searchText.lowercased()) }))
        }.sorted(by: { $0.0 > $1.0 })
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
            for item in clothes {
                Task {
                    do {
                        let uiImage = try await ImageCacheManager.shared.loadImage(from: item.picture.url)
                        let image = Image(uiImage: uiImage)
                        self.images[item.id] = (image, item.picture.description)
                    } catch {
                        errorMessage = "Une erreur est survenue en chargeant les images"
                    }
                }
            }
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
    
    func updateInfo(for cloth: Cloth) {
        guard let index = clothes.firstIndex(where: { $0.id == cloth.id }) else {
            return
        }
        clothes[index] = cloth
    }
}
