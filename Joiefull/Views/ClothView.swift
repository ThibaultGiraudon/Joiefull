//
//  ClothView.swift
//  Joiefull
//
//  Created by Thibault Giraudon on 07/07/2025.
//

import SwiftUI

struct ClothView: View {
    @State var cloth: Cloth
    
    @ScaledMetric var height: CGFloat = 200
    @ScaledMetric var width: CGFloat = 200
    
    @EnvironmentObject var viewModel: ClothesViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            if let (image, description) = viewModel.images[cloth.id] {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: height)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .accessibilityElement()
                    .accessibilityLabel(description)
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
                        .accessibilityHidden(true)
                    }
            } else {
                ProgressView()
            }
            ClothInfoView(cloth: cloth)
        }
        .frame(width: width)
    }
}

#Preview {
    let cloth = DefaultData().cloth
    ClothView(cloth: cloth)
        .frame(width: 200)
}
