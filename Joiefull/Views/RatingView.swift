//
//  RatingView.swift
//  Joiefull
//
//  Created by Thibault Giraudon on 08/07/2025.
//

import SwiftUI

struct RatingView: View {
    @Binding var cloth: Cloth
    var save: (Double, String) -> ()
    
    @State private var rating = 0.0
    @State private var review = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack(alignment: .center) {
                Image(systemName: "person.circle")
                ForEach(1...5, id: \.self) { value in
                    Image(systemName: rating >= Double(value) ? "star.fill" : "star")
                        .foregroundStyle(rating >= Double(value) ? .orange : .gray)
                        .onTapGesture {
                            rating = Double(value)
                        }
                        .accessibilityLabel("\(value) étoile\(value > 1 ? "s" : "")")
                        .accessibilityAddTraits(rating == Double(value) ? .isSelected : [])
                }
            }
            .font(.largeTitle)
            .accessibilityElement(children: .contain)
            .accessibilityLabel("Choisis ta note")
            .accessibilityValue("\(Int(rating)) étoile\(rating > 1 ? "s" : "") sélectionnée")

            TextField("Partagez ici vos impressions sur cette pièce", text: $review, axis: .vertical)
                .lineLimit(5...10)
                .multilineTextAlignment(.leading)
                .padding(10)
                .background {
                    RoundedRectangle(cornerRadius: 10).stroke()
                }
                .padding(.vertical)
                .accessibilityLabel("Zone de texte pour ton avis")
                .accessibilityHint("Double-tape pour commencer à écrire")

            Button {
                save(rating, review)
                rating = 0.0
                review = ""
            } label: {
                Text("Envoyer")
                    .font(.title2.bold())
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.orange.opacity(rating == 0 || review.isEmpty ? 0.6 : 1))
            }
            .disabled(rating == 0 || review.isEmpty)
            .accessibilityLabel("Envoyer l'avis")
            .accessibilityHint(rating == 0 || review.isEmpty ? "Remplis une note et un commentaire pour activer ce bouton" : "Double-tape pour envoyer ton avis")
            .accessibilityAddTraits(.isButton)
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var cloth = DefaultData().cloth
    RatingView(cloth: $cloth) { _, _ in
        
    }
}
