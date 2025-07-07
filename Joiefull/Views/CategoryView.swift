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
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title.bold())
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(clothes.filter({ $0.categoryItem == filter })) { cloth in
                        ClothView(cloth: cloth)
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
