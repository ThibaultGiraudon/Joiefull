//
//  Bundle+decode.swift
//  PeriGo
//
//  Created by Thibault Giraudon on 07/07/2025.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            print("Failed to locate \(file) in bundle.")
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            print("Failed to load datas from \(file)")
            fatalError("Failed to load datas from \(file)")
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Failed to decode datas from \(file): \(error.localizedDescription)")
            fatalError("Failed to decode datas from \(file): \(error.localizedDescription)")
        }
    }
}
