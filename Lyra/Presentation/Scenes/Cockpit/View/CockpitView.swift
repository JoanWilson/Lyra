//
//  CockpitView.swift
//  Lyra
//
//  Created by Luiz Sena on 10/04/23.
//

import SwiftUI
import SpriteKit

struct CockpitView: View {

    @AppStorage("showingTutorial") var showingTutorial: Bool = true

    var body: some View {
        ZStack {
            CockpitRepresentable(paused: $showingTutorial)
            if showingTutorial {
                TutorialRuneView()
                    .onTapGesture {
                        showingTutorial = false
                    }
            }
            
        }
        .ignoresSafeArea()
    }
}

struct CockpitView_Previews: PreviewProvider {
    static var previews: some View {
        CockpitView()
    }
}
