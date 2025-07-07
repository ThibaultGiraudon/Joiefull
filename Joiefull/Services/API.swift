//
//  API.swift
//  Joiefull
//
//  Created by Thibault Giraudon on 07/07/2025.
//

import Foundation

class API: ObservableObject {
    let url = URL(string: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/api/clothes.json")!
    
    func call() async throws -> [Cloth] {
        var clothes: [Cloth] = []
        
        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.timeoutInterval = 5
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard httpResponse.statusCode == 200 else {
            throw URLError(.badURL)
        }
        
        clothes = try JSONDecoder().decode([Cloth].self, from: data)

        return clothes
    }
}
