//
//  Cloth.swift
//  Joiefull
//
//  Created by Thibault Giraudon on 07/07/2025.
//

import Foundation

struct Cloth: Identifiable, Codable {
    var id: Int
    var picture: Picture
    var name: String
    var category: String
    var likes: Int
    var price: Double
    var originalPrice: Double
    
    struct Picture: Codable {
        var url: URL
        var description: String
    }
    
    enum CodingKeys: String, CodingKey {
        case id, picture, name, category, likes, price
        case originalPrice = "original_price"
    }
}
