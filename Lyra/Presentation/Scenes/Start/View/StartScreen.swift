//
//  StartScreen.swift
//  Lyra
//
//  Created by Luiz Sena on 11/04/23.
//

import SwiftUI

struct StartScreen: View {

    @State private var idle: Bool = false
    // vai ter q ter o binding ou state para saber de o usuário ja jogou ou não, caso sim aparece o botao continuar !

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("backgroundStorytelling")
                    .resizable()
                    .scaledToFill()
                    .scaleEffect(self.idle ? 5 : 1)
                    .rotationEffect(self.idle ? Angle(degrees: 180) : Angle(degrees: 0))
                    .animation(Animation.linear(duration: 100).repeatForever(), value: idle)
                    .ignoresSafeArea()
                Image("planet1")
                    .resizable()
                    .frame(width: 380 * geo.size.height/1024, height: 387 * geo.size.height/1024)
                    .position(x: geo.size.width/10 , y: geo.size.height/1.5)
                    .scaleEffect(self.idle ? 0.9 : 1)
                    .animation(Animation.linear(duration: 3).repeatForever(), value: idle)
                Image("planet2")
                    .resizable()
                    .frame(width: 524 * geo.size.height/1024, height: 485 * geo.size.height/1024)
                    .position(x: geo.size.width/1.2 , y: geo.size.height/1.12)
                    .scaleEffect(self.idle ? 0.9 : 1)
                    .animation(Animation.linear(duration: 5).repeatForever(), value: idle)
                Image("planet3")
                    .resizable()
                    .frame(width: 268 * geo.size.height/1024, height: 277 * geo.size.height/1024)
                    .position(x: geo.size.width/1.15 , y: geo.size.height/2.5)
                    .scaleEffect(self.idle ? 0.9 : 1)
                    .animation(Animation.linear(duration: 3).repeatForever(), value: idle)
                Image("moon")
                    .resizable()
                    .frame(width: 233 * geo.size.height/1024, height: 238 * geo.size.height/1024)
                    .position(x: geo.size.width/6.5 , y: geo.size.height/5)
                    .scaleEffect(self.idle ? 0.9 : 1)
                    .animation(Animation.linear(duration: 10).repeatForever(), value: idle)

                VStack(spacing: 0) {
                    VStack(spacing: 0) {
                        ZStack{
                            Text("LYRA")
                                .font(.custom("Coustard-Regular", size: 300 * (geo.size
                                    .height/1024)))
                                .foregroundColor(Color("startLyraShadow"))
                                .offset(x: -7.5)
                            Text("LYRA")
                                .font(.custom("Coustard-Regular", size: 300 * (geo.size
                                    .height/1024)))
                                .foregroundColor(Color("startLyraColor"))
                        }
                        //                        .background(.red)
                        Text("Em defesa do espaço")
                            .font(.custom("NotoSans-Regular", size: 40 * (geo.size.width/1366)))
                            .foregroundColor(Color("startSubtitleColor"))
                            .offset(y: -100 * (geo.size.height/1024))
                    }

                    VStack(spacing: 40 * geo.size.height/1024) {
                        NavigationLink {
                            IntroCutscene01()
                                .navigationBarBackButtonHidden()
                        } label: {
                            ZStack {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 16)
                                        .frame(width: 500 * geo.size.width/1366, height: 100 * geo.size.height/1024)
                                        .foregroundColor(Color("startButtonShadow"))
                                        .offset(x: -3, y: 3)
                                    RoundedRectangle(cornerRadius: 16)
                                        .frame(width: 500 * geo.size.width/1366, height: 100 * geo.size.height/1024)
                                        .foregroundColor(Color("startButtonColor"))
                                }
                                Text("Novo Jogo")
                                    .font(.custom("NotoSans-Regular", size: 48 * geo.size.height/1024))
                                    .foregroundColor(Color("startLyraColor"))
                            }
                        }

//                        Button(
//                            action: {
//                                print("touch")
//                            },
//                            label: {
//                                ZStack {
//                                    ZStack{
//                                        RoundedRectangle(cornerRadius: 16)
//                                            .frame(width: 500 * geo.size.width/1366, height: 100 * geo.size.height/1024)
//                                            .foregroundColor(Color("startButtonShadow"))
//                                            .offset(x: -3, y: 3)
//                                        RoundedRectangle(cornerRadius: 16)
//                                            .frame(width: 500 * geo.size.width/1366, height: 100 * geo.size.height/1024)
//                                            .foregroundColor(Color("startButtonColor"))
//                                    }
//                                    Text("Continuar")
//                                        .font(.custom("NotoSans-Regular", size: 48 * (geo.size.height/1024)))
//                                        .foregroundColor(Color("startLyraColor"))
//                                }
//                            })
                    }
                    .offset(y: -25)
                }
                .position(x: geo.size.width/2, y: geo.size.height/2)
            }
            .onAppear {
                idle = true
            }
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
