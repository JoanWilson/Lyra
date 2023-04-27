//
//  EndOfLevel.swift
//  Lyra
//
//  Created by Luiz Sena on 26/04/23.
//

import SwiftUI

struct EndOfLevel: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .ignoresSafeArea()

                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color("historyBarColor"))
                    VStack {
                        Text("Bem Jogado!")
                            .font(.custom("Coustard-Regular", size: 100 * geo.size.height/1024))
                            .foregroundColor(.black)
                        Text("Você concluiu o Tutorial, aperte no botão a baixo para ajudar Lyra no restante de sua aventura!")
                            .font(.custom("NotoSans-Regular", size: 35 * geo.size.height/1024))
                            .padding([.trailing, .leading], geo.size.width * 0.08)
                            .foregroundColor(.black)
                    }
                    VStack{
                        Spacer()
                        Button {
                            //
                        } label: {
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: geo.size.width/5, height: geo.size.height/9)
                                .foregroundColor(Color("startButtonColor"))
                                .overlay(Image(systemName: "arrow.right")
                                    .font(.system(size: geo.size.width/22))
                                    .foregroundColor(.white))

                        }
                        .padding(.bottom, geo.size.height/15)


                    }
                }
                .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.8)
            }

        }
    }
}

struct EndOfLevel_Previews: PreviewProvider {
    static var previews: some View {
        EndOfLevel()
    }
}
