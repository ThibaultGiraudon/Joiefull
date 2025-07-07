//
//  CategoryView.swift
//  Joiefull
//
//  Created by Thibault Giraudon on 07/07/2025.
//

import SwiftUI

struct CategoryView: View {
    var title: String
    var clothes: [Cloth]
    var filter: Cloth.Category
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var size: CGSize {
        if horizontalSizeClass == .compact {
            return CGSize(width: 200, height: 200)
        }
        return CGSize(width: 221, height: 312)
    }
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title.bold())
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(clothes.filter({ $0.categoryItem == filter })) { cloth in
                        ClothView(cloth: cloth, size: size)
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    CategoryView(title: "Hauts", clothes: DefaultData().clothes, filter: .top) 
}
