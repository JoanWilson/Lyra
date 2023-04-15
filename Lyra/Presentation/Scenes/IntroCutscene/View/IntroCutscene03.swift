//
//  IntroCutscene03.swift
//  Lyra
//
//  Created by Luiz Sena on 12/04/23.
//

import SwiftUI

struct IntroCutscene03: View {

    @State var idle: Bool = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                CutsceneView(historyText: "Mas uma pequena comunidade de rebeldes, liderados por uma jovem chamada Lyra, estava determinada a derrubar a Federação e restaurar a liberdade e a justiça para todos. Eles haviam descoberto algo que poderia ajudá-los em sua luta: **a magia.**")
                Image("Lyra")
                    .resizable()
                    .frame(width: geo.size.width/3 * 0.95, height: geo.size.height/1.755)
                    .mask {
                        Rectangle()
                            .frame(height: geo.size.height/2.28)
                        Spacer()
                    }
                    .position(x: geo.size.width/1.3, y: geo.size.height/1.765)

                Image("basicRune")
                    .resizable()
                    .frame(width: 781/3 * geo.size.width/1366, height: 1017/3 * geo.size.height/1024)
                    .position(x: geo.size.width/2, y: geo.size.height/3)
                    .rotationEffect(idle ? Angle(degrees: 5) : Angle(degrees: -5))
                    .shadow(color: .purple, radius: 5)
                    .animation(Animation.linear(duration: 2).repeatForever(), value: idle)

            }
            .onAppear {
                idle = true
            }
        }
    }
}

struct IntroCutscene03_Previews: PreviewProvider {
    static var previews: some View {
        IntroCutscene03()
    }
}
