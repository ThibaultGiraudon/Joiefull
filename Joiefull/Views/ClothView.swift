//
//  ClothView.swift
//  Joiefull
//
//  Created by Thibault Giraudon on 07/07/2025.
//

import SwiftUI

struct ClothView: View {
    var cloth: Cloth
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: cloth.picture.url) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            } placeholder: {
                ProgressView()
            }
            HStack {
                Text(cloth.name)
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
    }
}

#Preview {
    let clothes: [Cloth] = Bundle.main.decode(file: "clothes.json")
    ClothView(cloth: clothes.first!)
        .frame(width: 200, height: 200)
}
