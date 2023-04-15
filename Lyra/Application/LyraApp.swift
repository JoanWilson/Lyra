//
//  LyraApp.swift
//  Lyra
//
//  Created by Joan Wilson Oliveira on 03/04/23.
//

import SwiftUI

@main
struct LyraApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .ignoresSafeArea()
                .persistentSystemOverlays(.hidden)
        }
    }
}
