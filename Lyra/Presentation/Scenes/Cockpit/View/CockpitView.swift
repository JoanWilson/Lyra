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
    @State var showingLevelView: Bool = false

    var body: some View {
        ZStack {
            CockpitRepresentable(paused: $showingTutorial, showingLevelView: $showingLevelView, moveToLevelViewDelegate: self)
            if showingTutorial {
                TutorialRuneView()
                    .onTapGesture {
                        showingTutorial = false
                    }
            }
        }
        .onAppear {
            SoundManager.instance.stop()
        }
        .ignoresSafeArea()
        .navigationDestination(isPresented: $showingLevelView) {
            EndOfLevel()
                .navigationBarBackButtonHidden()
        }
    }
}

extension CockpitView: MoveToLevelView {
    func moveToLevelView() {
        self.showingLevelView = true
    }
}

struct CockpitView_Previews: PreviewProvider {
    static var previews: some View {
        CockpitView()
    }
}
