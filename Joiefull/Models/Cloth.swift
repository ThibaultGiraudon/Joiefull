//
//  Cloth.swift
//  Joiefull
//
//  Created by Thibault Giraudon on 07/07/2025.
//

import Foundation

struct Cloth: Identifiable, Codable, Hashable {
    var id: Int
    var picture: Picture
    var name: String
    var category: String
    var categoryItem: Category {
        switch self.category {
        case "ACCESSORIES":
            return .accessories
        case "BOTTOMS":
            return .bottoms
        case "SHOES":
            return .shoes
        case "TOPS":
            return .top
        default:
            return .none
        }
    }
    var likes: Int
    var price: Double
    var originalPrice: Double
    var isLiked: Bool = false
    var rating: Double = 4.0
    var reviews: [Review] = []
    
    struct Picture: Codable, Hashable {
        var url: URL
        var description: String
    }
    
    struct Review: Codable, Hashable {
        var rating: Double
        var review: String
    }
    
    enum CodingKeys: String, CodingKey {
        case id, picture, name, category, likes, price
        case originalPrice = "original_price"
    }
    
    enum Category: String {
        case top, shoes, bottoms, accessories, none
    }
}
