//
//  ClothInfoView.swift
//  Joiefull
//
//  Created by Thibault Giraudon on 07/07/2025.
//

import SwiftUI

struct ClothInfoView: View {
    var cloth: Cloth
    var body: some View {
        VStack {
            HStack {
                Text(cloth.name)
                    .lineLimit(1)
                    .bold()
                Spacer()
                Image(systemName: "star.fill")
                    .foregroundStyle(.orange)
                Text("4.4") // TODO add rate in model
            }
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
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label(for: cloth))
    }
    
    private func label(for cloth: Cloth) -> String {
        var components: [String] = []
        
        components.append(cloth.name)
        
        if cloth.originalPrice != cloth.price {
            components.append("\(cloth.name), en promotion, \(cloth.price.formatted(.currency(code: "EUR"))) au lieu de \(cloth.originalPrice.formatted(.currency(code: "EUR")))")
        } else {
            components.append("\(cloth.name), \(cloth.price.formatted(.currency(code: "EUR")))")
        }
        
        components.append("noté \(4.4) étoiles")
        
        return components.joined(separator: ",")
    }
}

#Preview {
    ClothInfoView(cloth: DefaultData().cloth)
}
