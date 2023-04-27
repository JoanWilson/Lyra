//
//  ContentView.swift
//  Lyra
//
//  Created by Joan Wilson Oliveira on 03/04/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            StartScreen()
                .onAppear {
                    SoundManager.instance.playForever(with: "mySound")
                }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
