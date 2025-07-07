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
            HStack {
                Text(cloth.name)
                    .lineLimit(1)
                Spacer()
                Image(systemName: "star.fill")
                    .foregroundStyle(.orange)
                Text("4.4") // TODO add rate in model
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel("noté \(4.4) étoiles")
            HStack {
                if cloth.originalPrice != cloth.price {
                    Text("\(cloth.price, format: .currency(code: "EUR"))")
                    Spacer()
                    Text("\(cloth.originalPrice, format: .currency(code: "EUR"))")
                        .strikethrough()
                } else {
                    Text("\(cloth.price, format: .currency(code: "EUR"))")                    
                }
            }
            .accessibilityLabel { _ in
                if cloth.originalPrice != cloth.price {
                    Text("\(cloth.name), en promotion, \(cloth.price.formatted(.currency(code: "EUR"))) au lieu de \(cloth.originalPrice.formatted(.currency(code: "EUR")))")
                } else {
                    Text("\(cloth.name), \(cloth.price.formatted(.currency(code: "EUR")))")
                }
            }
        }
        .frame(width: size.width)
    }
}

#Preview {
    ClothView(cloth: DefaultData().cloth, size: CGSize(width: 200, height: 200))
        .frame(width: 200, height: 200)
}
