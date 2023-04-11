//
//  CockpitViewController.swift
//  Lyra
//
//  Created by Luiz Sena on 10/04/23.
//

import UIKit
import SpriteKit

class CockpitViewController: UIViewController {

    lazy var skView: SKView = {
        let view = SKView()
        return view
    }()

    lazy var subView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()

    override func loadView() {
        self.view = skView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }

}

extension CockpitViewController: ViewCodeProtocol {

    func setUI() {
        let scene = GameScene(size: skView.bounds.size)
        //let scene = GameScene(size: CGSize(width: 2388, height: 1668))
        scene.scaleMode = .aspectFill
        scene.backgroundColor = .systemPurple

        skView.presentScene(scene)

        skView.ignoresSiblingOrder = false
        skView.showsPhysics = false
        skView.showsFPS = true
        skView.showsNodeCount = true
    }

    func setHierarchy() {
        self.skView.addSubview(subView)
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            subView.heightAnchor.constraint(equalToConstant: 100),
            subView.widthAnchor.constraint(equalToConstant: 100),
            subView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
