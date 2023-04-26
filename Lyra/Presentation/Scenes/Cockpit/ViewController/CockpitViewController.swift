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

    let scene: GameScene = GameScene(size: UIScreen.main.bounds.size)

    lazy var skView: SKView = {
        let view = SKView()
        return view
    }()

    lazy var subView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
        scene.isPaused = true

        skView.ignoresSiblingOrder = false
        skView.showsPhysics = false
        skView.showsFPS = true
        skView.showsNodeCount = true
    }

    func setHierarchy() {
        let sowiluGesture = SowiluGestureRecognizer(target: self, action: #selector(sowiluHandler)) //TIRAR DAQ
        let kaunaGesture = KaunaGestureRecognizer(target: self, action: #selector(kaunaHandler))    //TIRAR DAQ
        let uruzGesture = UruzGestureRecognizer(target: self, action: #selector(uruzHandler))   //TIRAR DAQ
        subView.addGestureRecognizer(sowiluGesture) //TIRAR DAQ
        subView.addGestureRecognizer(kaunaGesture) //TIRAR DAQ
        subView.addGestureRecognizer(uruzGesture) //TIRAR DAQ
//        subView.backgroundColor = .red
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

    @objc func sowiluHandler(_ c: UIGestureRecognizer) {
        if c.state == .ended {
            if GameScene.isAimLocked == true {
                scene.updateAirShipState()
            }
        }
    }
    @objc func kaunaHandler(_ c: UIGestureRecognizer) {
        if c.state == .ended {
            if GameScene.isAimLocked == true {
                scene.updateAirShipState()
            }
        }
    }
    @objc func uruzHandler(_ c: UIGestureRecognizer) {
        if c.state == .ended {
            if GameScene.isAimLocked == true {
                scene.updateAirShipState()
            }
        }
    }
}
