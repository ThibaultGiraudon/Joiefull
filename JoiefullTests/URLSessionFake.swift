//
//  URLSessionFake.swift
//  JoiefullTests
//
//  Created by Thibault Giraudon on 08/07/2025.
//

import Foundation
@testable import Joiefull

class URLSessionFake: URLSessionInterface {
    var error: Error?
    var data: Data = Data()
    var response: URLResponse = URLResponse()
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = error {
            throw error
        }
        
        return (data, response)
    }
}
