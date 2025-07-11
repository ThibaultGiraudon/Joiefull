//
//  FakeData.swift
//  JoiefullTests
//
//  Created by Thibault Giraudon on 08/07/2025.
//

import Foundation
@testable import Joiefull

struct FakeData {
    var correctData: Data? {
        let bundle = Bundle(for: JoiefullTests.self)
        guard let url = bundle.url(forResource: "FakeData.json", withExtension: nil) else {
            print("Failed to find FakeData.json in bundle")
            return nil
        }
        
        return try? Data(contentsOf: url)
    }
    
    var clothes: [Cloth]? {
        guard let correctData = self.correctData else {
            return nil
        }
        return try? JSONDecoder().decode([Cloth].self, from: correctData)
    }
    
    var correctResponse: URLResponse = HTTPURLResponse(url: URL(string: "https://openclassrooms.com/")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    
    var badResponse: URLResponse = HTTPURLResponse(url: URL(string: "https://openclassrooms.com/")!, statusCode: 400, httpVersion: nil, headerFields: nil)!
    
    var badResponse2: URLResponse = URLResponse(url: URL(string: "https://openclassrooms.com/")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
}
