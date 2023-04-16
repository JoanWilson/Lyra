//
//  LevelsView.swift
//  Lyra
//
//  Created by Paulo Henrique Gomes da Silva on 11/04/23.
//

import SwiftUI

struct LevelsView: View {

    @ObservedObject var viewModel = LevelsViewModel()

    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                ZStack {
                    Image("backgroundStorytelling")
                        .resizable()
                        .scaledToFill()
                        .blur(radius: 1)
                        .scaleEffect(viewModel.idle ? 2 : 1)
                        .animation(
                            Animation.linear(duration: 25).repeatForever(),
                            value: viewModel.idle
                        )
                    VStack {
                        Text("SELECIONE UM PLANETA")
                            .foregroundColor(.white)
                            .font(
                                .custom(
                                    "Coustard-Black",
                                    size: 48 * geo.size.width/1366
                                )
                            )
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(0..<viewModel.images.count, id:\.self) { level in
                                    VStack {
                                        NavigationLink(destination: IntroCutscene01()) {
                                            Image(viewModel.images[level])
                                                .shadow(
                                                    color: Color("historyBarColor"),
                                                    radius: viewModel.idle ? 13 : 5, x: 5, y: 5
                                                )
                                                .animation(
                                                    Animation.linear(duration: 1).repeatForever(),
                                                    value: viewModel.idle
                                                )
                                        }.frame(width: geo.size.width * 0.5)
                                        Text("\(viewModel.images[level])")
                                            .foregroundColor(.white)
                                            .font(
                                                .custom(
                                                    "Coustard-Regular",
                                                    size: 36 * geo.size.width/1366
                                                )
                                            )
                                    }
                                }
                            }
                        }
                    }.onAppear {
                        viewModel.idle = true
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
        LevelsView()
            .previewDevice(PreviewDevice(rawValue: "iPad mini (6th generation)"))
            .previewInterfaceOrientation(.landscapeLeft)
            .previewDisplayName("iPad mini")
    }
}
