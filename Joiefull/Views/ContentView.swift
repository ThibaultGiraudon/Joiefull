//
//  ContentView.swift
//  Joiefull
//
//  Created by Thibault Giraudon on 07/07/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var clothes: [Cloth] = []
    var body: some View {
        ScrollView(showsIndicators: false) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(clothes.filter({ $0.categoryItem == .accessories })) { cloth in
                        ClothView(cloth: cloth)
                    }
                }
            }
        }
        .onAppear {
            clothes = Bundle.main.decode(file: "clothes.json")
            print(clothes)
        }
    }
}

#Preview() {
    ContentView()
}

