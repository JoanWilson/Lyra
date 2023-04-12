//
//  LevelsView.swift
//  Lyra
//
//  Created by Paulo Henrique Gomes da Silva on 11/04/23.
//

import SwiftUI

struct LevelsView: View {

    @State private var images = ["moon", "planet1", "planet2", "planet3"]
    @State private var textos = ["teste1", "teste2", "teste3", "teste4"]
    @State private var idle: Bool = false

    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                ZStack {
                    Image("backgroundStorytelling")
                        .resizable()
                        .scaledToFill()
                        .blur(radius: 1)
                        .scaleEffect(idle ? 2 : 1)
                        .animation(Animation.linear(duration: 25).repeatForever(), value: idle)
                    VStack {
                        Text("SELECIONE UM PLANETA")
                            .foregroundColor(.white)
                            .font(.custom("Coustard-Black", size: 48))
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(0..<images.count, id:\.self) { level in
                                    VStack {
                                        NavigationLink(destination: IntroCutscene01()) {
                                            Image(images[level])
                                                .shadow(color: Color("historyBarColor"), radius: idle ? 13 : 5, x: 5, y: 5)
                                                .animation(Animation.linear(duration: 1).repeatForever(), value: idle)
                                        }.frame(width: geo.size.width * 0.5)
                                        Text("\(images[level])")
                                            .foregroundColor(.white)
                                            .font(.custom("Coustard-Regular", size: 36))
                                    }
                                }
                            }
                        }
                    }.onAppear {
                        idle = true
                    }
                }
            }
        }
    }
}

struct LevelsView_Previews: PreviewProvider {
    static var previews: some View {
        LevelsView()
            .previewDevice(PreviewDevice(rawValue: "iPad Air"))
            .previewInterfaceOrientation(.landscapeLeft)
            .previewDisplayName("iPad Air")
        LevelsView()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch) (4th generation)"))
            .previewInterfaceOrientation(.landscapeLeft)
            .previewDisplayName("iPad Pro")
    }
}
