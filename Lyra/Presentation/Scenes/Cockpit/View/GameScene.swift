//
//  GameScene.swift
//  Lyra
//
//  Created by Luiz Sena on 10/04/23.
//

import UIKit
import SpriteKit

class GameScene: SKScene {

    let background = SKSpriteNode(imageNamed: "battleBackground")
    let cockpit = SKSpriteNode(imageNamed: "cockpit")
    let airShip = SKSpriteNode(imageNamed: "enemySpaceship")



    override func didMove(to view: SKView) {
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.zPosition = -2
        cockpit.zPosition = 0
        airShip.zPosition = -1
        cockpit.anchorPoint = CGPoint(x: 0, y: 0)
        cockpit.scale(
            to: CGSize(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height
            )
        )
        background.scale(
            to: CGSize(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height
            )
        )
        self.addChild(background)
//        self.addChild(cockpit)
        self.addChild(airShip)

        backgroundColor = .red
    }

    override func didChangeSize(_ oldSize: CGSize) {
        airShip.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        airShip.position = CGPoint(x: frame.midX, y: frame.midY)
        airShip.scale(to: CGSize(width: size.width*0.2, height: size.height*0.2))
        configureMovement()
        //        airShip.texture = SKTexture(imageNamed: "rune")
    }
    
    func updateAirShipState() {
        airShip.texture = SKTexture(imageNamed: "rune")
    }

    func configureMovement() {
        lazy var path = UIBezierPath()
        path.move(to: CGPoint(x: frame.midX, y: frame.midY))
        path.addQuadCurve(to: CGPoint(x: frame.width/10*2,
                                      y: frame.midY),
                          controlPoint: CGPoint(x: frame.width/10*4,
                                                y: frame.height/10*6)
        )
        path.addQuadCurve(to: CGPoint(x: frame.midX,
                                      y: frame.midY),
                          controlPoint: CGPoint(x: frame.width/10*4,
                                                y: frame.height/10*4)
        )
        path.addQuadCurve(to: CGPoint(x: frame.width/10*8,
                                      y: frame.midY),
                          controlPoint: CGPoint(x: frame.width/10*6,
                                                y: frame.height/10*6)
        )
        path.addQuadCurve(to: CGPoint(x: frame.midX,
                                      y: frame.midY),
                          controlPoint: CGPoint(x: frame.width/10*6,
                                                y: frame.height/10*4)
        )
        let move = SKAction.follow(path.cgPath, asOffset: false, orientToPath: false, speed: 100)
//        airShip.run(SKAction.repeatForever(move))
        airShip.run(SKAction.repeat(move, count: 1000000))
    }

}

