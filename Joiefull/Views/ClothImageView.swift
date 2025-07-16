//
//  ClothImageView.swift
//  Joiefull
//
//  Created by Thibault Giraudon on 11/07/2025.
//

import SwiftUI

struct ClothImageView: View {
    @Binding var cloth: Cloth
    
    @EnvironmentObject var viewModel: ClothesViewModel
    
    @ScaledMetric var height: CGFloat = 405
    
    var body: some View {
        if let (image, _) = viewModel.images[cloth.id] {
            image
                .resizable()
                .scaledToFill()
                .frame(height: height)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .accessibilityHidden(true)
                .overlay(alignment: .bottomTrailing) {
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
                        viewModel.updateInfo(for: cloth)
                    }
                    .accessibilityElement()
                    .accessibilityHint("Double-tape pour \(cloth.isLiked ? "retirer le like" : "ajouter un like")")
                    .accessibilityAction {
                        cloth.isLiked.toggle()
                        cloth.likes += cloth.isLiked ? 1 : -1
                        viewModel.updateInfo(for: cloth)
                        
                        UIAccessibility.post(
                            notification: .announcement,
                            argument: cloth.isLiked ? "Ajouté aux favoris" : "Retiré des favoris"
                        )
                    }
                }
                .overlay(alignment: .topTrailing) {
                    ShareLink(item: cloth.picture.url, subject: Text("Jette un oeil à cet atricle"), message: Text(cloth.name)) {
                        Image("share")
                    }
                    .padding(10)
                    .foregroundStyle(.black)
                    .background {
                        Circle()
                            .fill(Material.ultraThin)
                    }
                    .padding(10)
                    .accessibilityLabel("Partager le vêtement")
                    .accessibilityHint("Double-tape pour ouvir les options de partage")
                }
        } else {
            ProgressView()
        }
    }
}
