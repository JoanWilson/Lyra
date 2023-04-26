//
//  TutorialRuneView.swift
//  Lyra
//
//  Created by Luiz Sena on 26/04/23.
//

import SwiftUI

struct TutorialRuneView: View {

    @State var isMouseAnimating: Bool = false
    @State var mouseCGSize: CGSize = CGSize(width: 0, height: 0)

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Rectangle()
                    .fill(.ultraThinMaterial)
                ZStack {
                    GeometryReader { insideGeo in
                        ZStack {
                            RoundedRectangle(cornerRadius: 25 )
                                .fill(Color("historyBarColor"))
                            VStack(spacing: 0) {
                                Text("Tutorial")
                                    .font(.custom("Coustard-Regular", size: 100 * insideGeo.size.height/1024))
                                    .foregroundColor(Color("startButtonShadow"))
                                    .padding(.top)

                                HStack {
                                    Image("tutorial1")
                                        .resizable()
                                        .frame(width: insideGeo.size.width*0.4,height: insideGeo.size.height*0.5)
                                        .mask(RoundedRectangle(cornerRadius: 15))
                                        .onAppear {
                                            isMouseAnimating = true
                                        }
                                    ZStack {
                                        Image("tutorial2")
                                            .resizable()
                                            .frame(width: insideGeo.size.width*0.4,height: insideGeo.size.height*0.5)
                                            .mask(RoundedRectangle(cornerRadius: 15))
                                        Image(systemName: "hand.point.up.left.fill")
                                            .foregroundColor(.white)
                                            .offset(CGSize(width: mouseCGSize.width/5.7, height: mouseCGSize.height))
                                            .shadow(color: Color.black, radius: 1)
                                    }
                                }
                                .onChange(of: isMouseAnimating) { newValue in
                                    withAnimation(.linear(duration: 1)) {
                                        mouseCGSize = CGSize(width: insideGeo.size.width, height: 0)
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        withAnimation(.linear(duration: 1)) {
                                            mouseCGSize = CGSize(width: insideGeo.size.width/1.4, height: insideGeo.size.height/15)

                                        }
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        withAnimation(.linear(duration: 1)) {
                                            mouseCGSize = CGSize(width: insideGeo.size.width, height: insideGeo.size.height/7)
                                        }
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                        withAnimation(.linear(duration: 1)) {
                                            mouseCGSize = CGSize(width: 0, height: 0)
                                        }
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                                        isMouseAnimating.toggle()
                                    }
                                }
                                Spacer()
                                    Text("Quando a mira ficar vermelha, desenhe o simbolo rúnico sobre a nave, na aréa representada de vermelho na figura.")
                                        .font(.custom("NotoSans-Regular", size: 60 * insideGeo.size.height/1024))
                                        .foregroundColor(Color("startButtonShadow"))
                                        .padding(.bottom, insideGeo.size.height * 0.1)
                                        .padding([.leading,.trailing], insideGeo.size.width * 0.08)
                            }
                        }
                    }
                }
                .frame(width: geo.size.width*0.65, height: geo.size.height*0.65)
            }
        }
        .ignoresSafeArea()
    }
}

struct TutorialRuneView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialRuneView()
    }
}
