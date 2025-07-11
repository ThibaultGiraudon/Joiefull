//
//  JoiefullApp.swift
//  Joiefull
//
//  Created by Thibault Giraudon on 07/07/2025.
//

import SwiftUI

@main
struct JoiefullApp: App {
    @StateObject var viewModel = ClothesViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
