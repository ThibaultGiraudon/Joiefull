//
//  ClothView.swift
//  Joiefull
//
//  Created by Thibault Giraudon on 07/07/2025.
//

import SwiftUI

struct ClothView: View {
    @Binding var cloth: Cloth
    
    @ScaledMetric var height: CGFloat = 200
    @ScaledMetric var width: CGFloat = 200
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: cloth.picture.url) { image in
                ZStack(alignment: .bottomTrailing) {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: width, height: height)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .accessibilityElement()
                        .accessibilityLabel(cloth.picture.description)
                    
                    HStack {
                        Image(systemName: cloth.isLiked ? "heart.fill" : "heart")
                        Text("\(cloth.likes)")
                    }
                    .padding(5)
                    .background {
                        Capsule()
                            .fill(.white)
                    }
                    .padding(10)
                    .onTapGesture(count: 2) {
                        cloth.isLiked.toggle()
                        cloth.likes += cloth.isLiked ? 1 : -1
                    }
                    .accessibilityHidden(true)

                }
            } placeholder: {
                ProgressView()
                    .accessibilityLabel("Chargement de l'image")
            }
            ClothInfoView(cloth: $cloth)
        }
        .frame(width: width)
    }
}

#Preview {
    @Previewable @State var cloth = DefaultData().cloth
    ClothView(cloth: $cloth)
        .frame(width: 200)
}
