//
//  CockpitViewController.swift
//  Lyra
//
//  Created by Luiz Sena on 10/04/23.
//

import UIKit
import SpriteKit

class CockpitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidLayoutSubviews() {
        let skView = SKView(frame: view.frame)
        skView.backgroundColor = .green
        self.view.addSubview(skView)
        if let view = skView as SKView? {
            let scene = GameScene(size: view.bounds.size)
//            let scene = GameScene(size: CGSize(width: 2388, height: 1668))
            scene.scaleMode = .aspectFill
            scene.backgroundColor = .systemPurple

            view.presentScene(scene)

            view.ignoresSiblingOrder = false
            view.showsPhysics = false
            view.showsFPS = true
            view.showsNodeCount = true
        }

        let subView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        subView.backgroundColor = .blue
        self.view.addSubview(subView)




    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
