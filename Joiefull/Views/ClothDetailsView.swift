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
                            .padding(10).onTapGesture(count: 2) {
                                cloth.isLiked.toggle()
                                cloth.likes += cloth.isLiked ? 1 : -1
                            }
                            .accessibilityElement()
                            .accessibilityLabel(cloth.isLiked ? "Vêtement aimé" : "Vêtement non aimé")
                            .accessibilityValue("\(cloth.likes) likes")
                            .accessibilityHint("Double-tape pour \(cloth.isLiked ? "retirer le like" : "ajouter un like")")
                            .accessibilityAction {
                                cloth.isLiked.toggle()
                                cloth.likes += cloth.isLiked ? 1 : -1
                                
                                UIAccessibility.post(
                                    notification: .announcement,
                                    argument: cloth.isLiked ? "Ajouté aux favoris" : "Retiré des favoris"
                                )
                            }
                        }
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
                } placeholder: {
                    ProgressView()
                        .accessibilityLabel("Chargement de l'image")
                }
                .padding(.bottom)
                ClothInfoView(cloth: $cloth)
                    .font(.title2)
                Text(cloth.picture.description)
                RatingView(cloth: $cloth) { rating, review in
                    cloth.reviews.append(Cloth.Review(rating: rating, review: review))
                    UIAccessibility.post(
                        notification: .announcement,
                        argument: "Avis envoyé"
                    )
                }
                ForEach(cloth.reviews, id: \.self) { review in
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "person.circle")
                            ForEach(1...5, id: \.self) { value in
                                Image(systemName: review.rating >= Double(value) ? "star.fill" : "star")
                            }
                        }
                        .accessibilityLabel("Note utilisateur")
                        .accessibilityValue("\(Int(review.rating)) sur 5 étoiles")
                        Text(review.review)
                            .multilineTextAlignment(.leading)
                            .accessibilityLabel("Avis utilisateur")
                            .accessibilityValue(review.review)
                    }
                    .padding(.vertical)
                }
            }
        }
        .padding()
        .onAppear {
            UIAccessibility.post(
                notification: .announcement,
                argument: "Détail du vêtement affiché"
            )
        }
    }
}

#Preview {
    @Previewable @State var cloth = DefaultData().cloth
    ClothDetailsView(cloth: $cloth)
        .frame(width: 400)
}
