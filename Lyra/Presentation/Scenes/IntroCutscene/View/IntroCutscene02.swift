//
//  IntroCutscene02.swift
//  Lyra
//
//  Created by Luiz Sena on 12/04/23.
//

import SwiftUI

struct IntroCutscene02: View {
    @State var idle: Bool = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                CutsceneView(historyText: "No entanto, nem tudo era perfeito. Um governo tirano, conhecido como a Federação, havia surgido impondo leis rigorosas e controlando a vida de todos os cidadãos. Aqueles que se opunham ao governo eram presos ou executados sem julgamento justo.")
                Image("explodedPlanet1")
                    .resizable()
                    .frame(width: 390 * geo.size.width/1366, height: 332 * geo.size.height/1024)
                    .position(x: geo.size.width/1.3, y: geo.size.height/3)
                    .scaleEffect(idle ? 0 : 1)
                    .animation(Animation.linear(duration: 20), value: idle)
                Image("explodedPlanet2")
                    .resizable()
                    .frame(width: 213 * geo.size.width/1366, height: 245 * geo.size.height/1024)
                    .position(x: geo.size.width/5 , y: geo.size.height/5 )
                    .scaleEffect(idle ? 0 : 1)
                    .animation(Animation.linear(duration: 20), value: idle)
                Image("enemySpaceship")
                    .resizable()
                    .frame(width: 787 * geo.size.width/1366, height: 505 * geo.size.height/1024)
                    .position(x: geo.size.width/2.4, y: geo.size.height/2.2)
                    .scaleEffect(idle ? 1.6 : 1)
                    .offset(x: idle ? geo.size.width-500 : 0, y: 0)
//                    .opacity(idle ? 0 : 1)
                    .animation(Animation.linear(duration: 20), value: idle)
                
            }
            .onAppear {
                idle = true
            }
        }
    }
}

struct IntroCutscene02_Previews: PreviewProvider {
    static var previews: some View {
        IntroCutscene02()
    }
}
