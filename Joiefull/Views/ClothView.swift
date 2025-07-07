//
//  ClothView.swift
//  Joiefull
//
//  Created by Thibault Giraudon on 07/07/2025.
//

import SwiftUI

struct ClothView: View {
    var cloth: Cloth
    var size: CGSize
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: cloth.picture.url) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .accessibilityLabel(cloth.picture.description)
            } placeholder: {
                ProgressView()
                    .accessibilityLabel("Chargement de l'image")
            }
            ClothInfoView(cloth: cloth)
        }
        .frame(width: size.width)
    }
}

#Preview {
    ClothView(cloth: DefaultData().cloth, size: CGSize(width: 200, height: 200))
        .frame(width: 200)
}
