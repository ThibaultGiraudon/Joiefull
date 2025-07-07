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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            clothes = Bundle.main.decode(file: "clothes.json")
            print(clothes)
        }
    }
}

#Preview("Ipad") {
    ContentView()
}

#Preview("Iphone") {
    ContentView()
}
