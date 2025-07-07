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
                return .top
        }
    }
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
    
    enum Category: String {
        case top, shoes, bottoms, accessories
    }
}
