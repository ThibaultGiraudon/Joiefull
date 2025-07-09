//
//  API.swift
//  Joiefull
//
//  Created by Thibault Giraudon on 07/07/2025.
//

import Foundation

protocol URLSessionInterface {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionInterface { }


class API: ObservableObject {
    let url = URL(string: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/api/clothes.json")!
    
    var session: URLSessionInterface
    
    init(session: URLSessionInterface = URLSession.shared) {
        self.session = session
    }
    
    func call() async throws -> [Cloth] {
        var clothes: [Cloth] = []
        
        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.timeoutInterval = 5
        
        let (data, response) = try await session.data(for: request)
        
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
