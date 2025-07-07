//
//  DefaultData.swift
//  Joiefull
//
//  Created by Thibault Giraudon on 07/07/2025.
//

import Foundation

class DefaultData {
    let clothes: [Cloth] = [
        Cloth(id: 1, picture: Cloth.Picture(url: URL(string: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/bottoms/1.jpg")!, description: "Modèle femme qui porte un jean et un haut jaune"), name: "Jean pour femme", category: "BOOTOMS", likes: 55, price: 49.99, originalPrice: 59.99),
        Cloth(id: 2, picture: Cloth.Picture(url: URL(string: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/bottoms/2.jpg")!, description: "Homme en chemise blanche et pantalon noir assis dans la forêt"), name: "Pantalon noir", category: "BOOTOMS", likes: 54, price: 49.99, originalPrice: 69.99),
    ]
    
    let cloth: Cloth = .init(id: 1, picture: Cloth.Picture(url: URL(string: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/tops/2.jpg")!, description: "Homme en chemise blanche et pantalon noir assis dans la forêt"), name: "Pantalon noir", category: "BOOTOMS", likes: 54, price: 49.99, originalPrice: 69.99)
}
