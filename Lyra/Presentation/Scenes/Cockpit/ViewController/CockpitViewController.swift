//
//  CockpitViewController.swift
//  Lyra
//
//  Created by Luiz Sena on 10/04/23.
//

import UIKit
import SpriteKit

protocol RuneGestureDelegate: AnyObject{
    func updateAirShipState()
}

class CockpitViewController: UIViewController {

    let scene = GameScene(size: UIScreen.main.bounds.size)

    lazy var skView: SKView = {
        let view = SKView()
        return view
    }()

    lazy var subView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .blue
        view.layer.opacity = 0.3
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
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)

        skView.ignoresSiblingOrder = false
        skView.showsPhysics = false
        skView.showsFPS = true
        skView.showsNodeCount = true
    }

    func setHierarchy() {
        let myGesture = SowiluGestureRecognizer(target: self, action: #selector(circled))
        subView.addGestureRecognizer(myGesture) //TIRAR DAQ
        subView.backgroundColor = .red
        self.skView.addSubview(subView)
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            subView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height*0.7),
            subView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*0.3),
            subView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            subView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }

    @objc func circled(_ c: UIGestureRecognizer) {
        if c.state == .ended {
            scene.updateAirShipState()
        }
    }
}
