//
//  ClothDetailsView.swift
//  Joiefull
//
//  Created by Thibault Giraudon on 07/07/2025.
//

import SwiftUI

struct ClothDetailsView: View {
    @Binding var cloth: Cloth
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var height: CGFloat {
        if horizontalSizeClass == .compact {
            return 431
        }
        return 405
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                AsyncImage(url: cloth.picture.url) { image in
                    ZStack(alignment: .topTrailing) {
                        ZStack(alignment: .bottomTrailing) {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: height)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 20))
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
                                if cloth.isLiked == true {
                                    cloth.likes += 1
                                } else {
                                    cloth.likes -= 1
                                }
                            }
                            .accessibilityElement()
                            .accessibilityLabel(cloth.isLiked ? "Vêtement aimé" : "Vêtement non aimé")
                            .accessibilityHint("Double-tape pour \(cloth.isLiked ? "retirer le like" : "ajouter un like")")
                        }
                        ShareLink(item: cloth.picture.url, subject: Text("Jette un oeil à cet atricle"), message: Text(cloth.name)) {
                            Image("share")
                        }
                        .padding()
                        .foregroundStyle(.black)
                    }
                } placeholder: {
                    ProgressView()
                        .accessibilityLabel("Chargement de l'image")
                }
                .padding(.bottom)
                ClothInfoView(cloth: cloth)
                    .font(.title2)
                Text(cloth.picture.description)
            }
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var cloth = DefaultData().cloth
    ClothDetailsView(cloth: $cloth)
        .frame(width: 400)
}
