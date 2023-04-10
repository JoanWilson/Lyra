//
//  CockpitView.swift
//  Lyra
//
//  Created by Luiz Sena on 10/04/23.
//

import SwiftUI
import SpriteKit

struct CockpitView: View {
    var body: some View {
        CockpitRepresentable()
            .ignoresSafeArea()
    }
}

struct CockpitView_Previews: PreviewProvider {
    static var previews: some View {
        CockpitView()
    }
}
