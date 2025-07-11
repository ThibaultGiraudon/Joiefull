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

enum APIError: Error, LocalizedError {
    case invalidResponse
    case invalidStatusCode(Int)
    case decodingError
    case networkError(Error)
}

class API {
    let url = URL(string: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/api/clothes.json")!
    
    var session: URLSessionInterface
    
    init(session: URLSessionInterface = URLSession.shared) {
        self.session = session
    }
    
    func call() async throws -> [Cloth] {
        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.timeoutInterval = 5
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("throw invalidResponse")
                throw APIError.invalidResponse
            }
            
            guard httpResponse.statusCode == 200 else {
                throw APIError.invalidStatusCode(httpResponse.statusCode)
            }
            
            do {
                return try JSONDecoder().decode([Cloth].self, from: data)
            } catch {
                throw APIError.decodingError
            }
            
        } catch {
            if let apiError = error as? APIError {
                throw apiError
            } else {
                throw APIError.networkError(error)
            }
        }

    }
}
