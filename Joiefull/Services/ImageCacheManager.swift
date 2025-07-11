//
//  ImageCacheManager.swift
//  Joiefull
//
//  Created by Thibault Giraudon on 11/07/2025.
//

import Foundation
import SwiftUI

class ImageCacheManager {
    static let shared = ImageCacheManager()

    private var cache = NSCache<NSURL, UIImage>()

    private init() {}

    func image(for url: URL) -> UIImage? {
        return cache.object(forKey: url as NSURL)
    }

    func setImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }

    func loadImage(from url: URL) async throws -> UIImage {
        if let cached = image(for: url) {
            return cached
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw URLError(.cannotDecodeContentData)
        }

        setImage(image, for: url)
        return image
    }
}
