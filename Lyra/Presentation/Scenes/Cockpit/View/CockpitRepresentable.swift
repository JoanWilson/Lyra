//
//  CockpitRepresentable.swift
//  Lyra
//
//  Created by Luiz Sena on 10/04/23.
//

import SwiftUI
import UIKit

struct CockpitRepresentable: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = CockpitViewController()
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }

}
