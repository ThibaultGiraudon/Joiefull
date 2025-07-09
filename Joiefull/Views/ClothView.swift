//
//  ClothView.swift
//  Joiefull
//
//  Created by Thibault Giraudon on 07/07/2025.
//

import SwiftUI

struct ClothView: View {
    @Binding var cloth: Cloth
    var size: CGSize
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: cloth.picture.url) { image in
                ZStack(alignment: .bottomTrailing) {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
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

                }
            } placeholder: {
                ProgressView()
                    .accessibilityLabel("Chargement de l'image")
            }
            ClothInfoView(cloth: $cloth)
        }
        .frame(width: size.width)
    }
}

#Preview {
    @Previewable @State var cloth = DefaultData().cloth
    ClothView(cloth: $cloth, size: CGSize(width: 200, height: 200))
        .frame(width: 200)
}
