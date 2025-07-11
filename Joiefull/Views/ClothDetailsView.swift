//
//  ClothDetailsView.swift
//  Joiefull
//
//  Created by Thibault Giraudon on 07/07/2025.
//

import SwiftUI

struct ClothDetailsView: View {
    var cloth: Cloth
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var body: some View {
        Group {
            if dynamicTypeSize > .large {
                ScrollView(.horizontal, showsIndicators: false) {
                    DetailsView(cloth: cloth)
                }
            } else {                
                DetailsView(cloth: cloth)
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

struct DetailsView: View {
    @State var cloth: Cloth
    
    @EnvironmentObject var viewModel: ClothesViewModel
    @ScaledMetric var height: CGFloat = 405
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                ClothImageView(cloth: $cloth)
                .padding(.bottom)
                
                ClothInfoView(cloth: cloth)
                    .font(.title2)
                
                Text(cloth.picture.description)
                
                RatingView(cloth: cloth) { rating, review in
                    cloth.reviews.append(Cloth.Review(rating: rating, review: review))
                    viewModel.updateInfo(for: cloth)
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
                        .accessibilityElement(children: .combine)
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
    }
}

#Preview {
    let cloth = DefaultData().cloth
    ClothDetailsView(cloth: cloth)
        .frame(width: 400)
}
