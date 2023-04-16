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

    // Usados na func
    @State var aux = 0
    @State var rangeMarkdown: (startIndex: Int?, endIndex: Int?) = (nil, nil)


    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .center) {
                Image("backgroundStorytelling")
                    .resizable()
                    .frame(width: 1366 * geo.size.width/1366, height: 1024 * geo.size.height/1024)
                    .scaledToFill()
                    .scaleEffect(self.idle ? 2 : 1)
                    .animation(Animation.linear(duration: 60).repeatForever(), value: idle)
                VStack {
                    Spacer()
                    Rectangle()
                        .frame(width: geo.size.width,
                               height: geo.size.height * 0.28)
                        .foregroundColor(Color("historyBarColor"))
                        .overlay {
                            let markdown = try! AttributedString(markdown: text )
                            Text(markdown)
                                .font(.custom("Coustard-Regular", size: 27 * geo.size.width/1366 ))
                                .padding(EdgeInsets(top: 0, leading: 68, bottom: 10, trailing: 68))
                                .colorInvert()
                        }
                }
            }
            .scaledToFit()
        }
        .onAppear {
            typeWriter()
            idle = true
        }.ignoresSafeArea()
    }

    func typeWriter(at position: Int = 0) {

        if position == 0 {
            text = ""
        }
        if position < historyText.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.04) {
                if historyText[position] == "*" {
                    aux += 1
                    text.append("")
                    typeWriter(at: position + 1)
                    if aux == 2 {
                        rangeMarkdown.startIndex = position-1
                    }
                    if aux == 3 {
                        rangeMarkdown.endIndex = position
                    }
                } else {
                    text.append(historyText[position])
                    typeWriter(at: position + 1)
                }

            }
        }
        if position == historyText.count {
            if let startRange = rangeMarkdown.startIndex {
                text.insert("*", at: text.index(text.startIndex, offsetBy: startRange))
                text.insert("*", at: text.index(text.startIndex, offsetBy: startRange))
                text.insert("*", at: text.index(text.startIndex, offsetBy: rangeMarkdown.endIndex!))
                text.insert("*", at: text.index(text.startIndex, offsetBy: rangeMarkdown.endIndex!))
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
