//
//  CutsceneGuideView.swift
//  Lyra
//
//  Created by Luiz Sena on 11/04/23.
//

import SwiftUI

struct CutsceneView: View {
    @State private var text: String = ""
    // finalText está atualmente mockado, mas o ideal seria na chamada da view a injecao do dado!
    let historyText: String
    @State private var idle: Bool = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("backgroundStorytelling")
                    .resizable()
                    .scaledToFill()
                    .scaleEffect(self.idle ? 2 : 1)
//                    .rotationEffect(self.idle ? Angle(degrees: 180) : Angle(degrees: 0))
                    .animation(Animation.linear(duration: 25).repeatForever(), value: idle)
                VStack {
                    Spacer()
                    Rectangle()
                        .frame(width: geo.size.width,
                               height: geo.size.height * 0.28)
                        .foregroundColor(Color("historyBarColor"))
                        .overlay {
                            Text(text)
                                .font(.custom("Coustard-Regular", size: 34 ))
                                .padding(EdgeInsets(top: 0, leading: 68, bottom: 10, trailing: 68))
                        }
                }
            }.scaledToFit()
        }
        .onAppear {
            typeWriter()
            idle = true
        }
    }

    func typeWriter(at position: Int = 0) {
        if position == 0 {
            text = ""
        }
        if position < historyText.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                text.append(historyText[position])
                typeWriter(at: position + 1)
            }
        }
    }
}


struct CutsceneGuideView_Previews: PreviewProvider {
    static var previews: some View {
        CutsceneView(historyText: "apenas teste")
    }
}

// saber onde colocar essa extension
extension String {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
