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
                    .frame(width: 989 * geo.size.width/1366, height: 483 * geo.size
                        .height/1024)
                    .offset(y: -100)
                    .shadow(color: Color(cgColor: CGColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)), radius: idle ? 45 : 10)
                    .offset(y: idle ? -25 : 0)
                    .animation(Animation.linear(duration: 2).repeatForever(), value: idle)

            }
            .onAppear {
                idle = true
                print(geo.size.width/1366)
            }
        }
    }
}

struct IntroCutscene01_Previews: PreviewProvider {
    static var previews: some View {
        IntroCutscene01()
    }
}
