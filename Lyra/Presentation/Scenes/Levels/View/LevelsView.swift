//
//  LevelsView.swift
//  Lyra
//
//  Created by Paulo Henrique Gomes da Silva on 11/04/23.
//

import SwiftUI

struct LevelsView: View {

    var body: some View {
        NavigationStack {
            ZStack {
                Image("background")
                    .scaledToFill()
                    .blur(radius: 5)
                HStack(spacing: UIScreen.main.bounds.width/8) {
                    ForEach(1..<5) { level in
                        NavigationLink(destination: CockpitView()) {
                            Text("Teste")
                                .font(.system(size: 48))
                        }
                    }
                }
            }
        }
    }
}

struct LevelsView_Previews: PreviewProvider {
    static var previews: some View {
        LevelsView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
