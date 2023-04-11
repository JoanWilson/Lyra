//
//  StartScreen.swift
//  Lyra
//
//  Created by Luiz Sena on 11/04/23.
//

import SwiftUI

struct StartScreen: View {

    @State var idle: Bool = false

    var body: some View {
        ZStack {
            Image("backgroundStorytelling")
                .resizable()
                .scaledToFill()
                .scaleEffect(self.idle ? 5 : 1)
                .rotationEffect(self.idle ? Angle(degrees: 180) : Angle(degrees: 0))
                .animation(Animation.linear(duration: 100).repeatForever(), value: idle)
            GeometryReader { geo in
                Image("planet1")
                    .position(x: geo.size.width/10 , y: geo.size.height/1.5)
                    .scaleEffect(self.idle ? 0.9 : 1)
                    .animation(Animation.linear(duration: 3).repeatForever(), value: idle)
                Image("planet2")
                    .position(x: geo.size.width/1.2 , y: geo.size.height/1.12)
                    .scaleEffect(self.idle ? 0.9 : 1)
                    .animation(Animation.linear(duration: 5).repeatForever(), value: idle)
                Image("planet3")
                    .position(x: geo.size.width/1.2 , y: geo.size.height/2.5)
                    .scaleEffect(self.idle ? 0.9 : 1)
                    .animation(Animation.linear(duration: 3).repeatForever(), value: idle)
                Image("moon")
                    .position(x: geo.size.width/6.5 , y: geo.size.height/5)
                    .scaleEffect(self.idle ? 0.9 : 1)
                    .animation(Animation.linear(duration: 10).repeatForever(), value: idle)

            }

            VStack(spacing: 0) {
                ZStack{
                    Text("Lyra")
                        .font(.custom("Coustard-Regular", size: 300))
                        .foregroundColor(Color("startLyraShadow"))
                        .offset(x: -7.5)
                    Text("Lyra")
                        .font(.custom("Coustard-Regular", size: 300))
                        .foregroundColor(Color("startLyraColor"))
                }
                Button(
                    action: {
                        print("touch")
                    },
                    label: {
                        ZStack {
                            ZStack{
                                RoundedRectangle(cornerRadius: 16)
                                    .frame(width: 500, height: 100)
                                    .foregroundColor(Color("startButtonShadow"))
                                    .offset(x: -3, y: 3)
                                RoundedRectangle(cornerRadius: 16)
                                    .frame(width: 500, height: 100)
                                    .foregroundColor(Color("startButtonColor"))
                            }
                            Text("Iniciar")
                                .font(.custom("Coustard-Regular", size: 48))
                                .foregroundColor(Color("startLyraColor"))
                        }
                    })
            }

        }
        .onAppear {
            idle = true
        }
    }
}

struct StartScreen_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen()
            .previewDevice("iPad Pro (11-inch) (4th generation)")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
