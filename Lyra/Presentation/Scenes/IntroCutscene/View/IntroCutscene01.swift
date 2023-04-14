//
//  IntroCutscene01.swift
//  Lyra
//
//  Created by Luiz Sena on 11/04/23.
//

import SwiftUI

struct IntroCutscene01: View {
    @State private var idle: Bool = false

    var body: some View {
        GeometryReader { geo in
            ZStack{
                CutsceneView(historyText: "A humanidade havia se espalhado por todo o universo, colonizando planetas distantes e desenvolvendo tecnologias avançadas que lhes permitiam viajar mais rápido do que a luz.")
                Image("universe1")
                    .resizable()
                    .frame(width: 989 * geo.size
                        .height/1024, height: 483 * geo.size
                        .height/1024)
                    .position(x: geo.size.width/2, y: geo.size.height/2.2)
                    .shadow(color: Color(cgColor: CGColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)), radius: idle ? 45 : 10)
                    .offset(y: idle ? -25 : 0)
                    .animation(Animation.linear(duration: 2).repeatForever(), value: idle)
                Image("universe2")
                    .resizable()
                    .frame(width: 255 * geo.size
                        .height/1024, height: 119 * geo.size.height/1024)
                    .position(x: geo.size.width/1.15, y: geo.size.height/6)
                Image("universe3")
                    .resizable()
                    .frame(width: 173 * geo.size
                        .height/1024, height: 112 * geo.size.height/1024)
                    .position(x: geo.size.width/6, y: geo.size.height/4.2)
            }
            .onAppear {
                idle = true
            }
        }
    }
}

struct IntroCutscene01_Previews: PreviewProvider {
    static var previews: some View {
        IntroCutscene01()
    }
}
