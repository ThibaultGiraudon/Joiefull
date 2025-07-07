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
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: height)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .accessibilityLabel(cloth.picture.description)
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
    ClothDetailsView(cloth: DefaultData().cloth)
}
