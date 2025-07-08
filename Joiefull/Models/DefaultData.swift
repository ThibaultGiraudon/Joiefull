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
    
    let cloth: Cloth = .init(id: 1, picture: Cloth.Picture(url: URL(string: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/tops/2.jpg")!, description: "Homme en chemise blanche et pantalon noir assis dans la forêt"), name: "Pantalon noir", category: "BOOTOMS", likes: 54, price: 49.99, originalPrice: 69.99, rating: 4.0, reviews: [
        Cloth.Review(rating: 3.0, review: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec tortor mi, dapibus eget arcu in, ultrices placerat lorem. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Praesent finibus dui vel massa accumsan ultrices. Phasellus vitae convallis orci. Aliquam laoreet est id rhoncus mollis. Suspendisse et convallis ligula. Nam ac felis vel purus eleifend luctus eget eu ex. Vestibulum a turpis egestas, tempor risus vel, rutrum velit."),
        Cloth.Review(rating: 4.0, review: "Aliquam ac lorem ac enim consectetur semper. Duis ut lectus finibus, vestibulum ligula ut, eleifend felis. In egestas nulla non massa finibus bibendum"),
        Cloth.Review(rating: 2.0, review: "Aliquam ac lorem ac enim consectetur semper."),
    ])
}
