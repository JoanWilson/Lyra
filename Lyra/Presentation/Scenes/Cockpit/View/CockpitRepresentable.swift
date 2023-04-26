//
//  CockpitRepresentable.swift
//  Lyra
//
//  Created by Luiz Sena on 10/04/23.
//

import SwiftUI
import UIKit

struct CockpitRepresentable: UIViewControllerRepresentable {

    @Binding var paused: Bool

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = CockpitViewController()
        print("scene is paused", paused)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        (uiViewController as! CockpitViewController).scene.isPaused = paused
    }

}
