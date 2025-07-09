//
//  ClothInfoView.swift
//  Joiefull
//
//  Created by Thibault Giraudon on 07/07/2025.
//

import SwiftUI

struct ClothInfoView: View {
    @Binding var cloth: Cloth
    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    var body: some View {
        VStack(alignment: .leading) {
            if dynamicTypeSize < .xLarge {
                HStack {
                    Text(cloth.name)
                        .lineLimit(1)
                        .bold()
                    Spacer()
                    Image(systemName: "star.fill")
                        .foregroundStyle(.orange)
                    Text("\(cloth.rating, specifier: "%.1f")")
                }
                .lineLimit(1)
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
                .lineLimit(1)
            } else {
                    Text(cloth.name)
                        .lineLimit(2)
                        .bold()
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.orange)
                    Text("\(cloth.rating, specifier: "%.1f")")
                }
                    Text("\(cloth.price, format: .currency(code: "EUR"))")
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label(for: cloth))
    }
    
    private func label(for cloth: Cloth) -> String {
        var components: [String] = []
        
        components.append(cloth.name)
        
        components.append("\(cloth.isLiked ? "vêtement aimé" : "")")
        
        components.append("\(cloth.likes) like")
        
        if cloth.originalPrice != cloth.price {
            components.append("en promotion, \(cloth.price.formatted(.currency(code: "EUR"))) au lieu de \(cloth.originalPrice.formatted(.currency(code: "EUR")))")
        } else {
            components.append("\(cloth.price.formatted(.currency(code: "EUR")))")
        }
        
        components.append("noté \(cloth.rating) étoiles")
        return components.joined(separator: ",")
    }
}

#Preview {
    @Previewable @State var cloth = DefaultData().cloth
    ClothInfoView(cloth: $cloth)
}
