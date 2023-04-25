//
//  GameScene.swift
//  Lyra
//
//  Created by Luiz Sena on 10/04/23.
//

import UIKit
import SpriteKit
import SwiftUI

class GameScene: SKScene {

    let background = SKSpriteNode(imageNamed: "battleBackground")
    let cockpit = SKSpriteNode(imageNamed: "cockpit")
    let airShip = SKSpriteNode(imageNamed: "enemySpaceship")
    let crossHair = SKSpriteNode(imageNamed: "crossHairGreen")
    static public var isAimLocked: Bool = false

    override func didMove(to view: SKView) {
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.zPosition = -2
        cockpit.zPosition = 0
        airShip.zPosition = -1
        crossHair.zPosition = -1
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
        physicsSetup()
        self.addChild(background)
        self.addChild(cockpit)
        self.addChild(airShip)
        self.addChild(crossHair)
    }

    override func didChangeSize(_ oldSize: CGSize) {
        airShip.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        airShip.position = CGPoint(x: frame.midX, y: frame.midY)
        airShip.scale(to: CGSize(width: size.width*0.2, height: size.height*0.2))
        //        airShip.texture = SKTexture(imageNamed: "rune")

        crossHair.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        crossHair.position = CGPoint(x: frame.midX, y: frame.midY)
        crossHair.scale(to: CGSize(width: size.width*0.2, height: size.width*0.2))

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        airShip.run(SKAction.move(to: location, duration: 1))
    }
    
    func updateAirShipState() {
        if airShip.texture?.description.count == SKTexture(imageNamed: "rune").description.count {
            airShip.texture = SKTexture(imageNamed: "enemySpaceship")
        } else {
            airShip.texture = SKTexture(imageNamed: "rune")
        }
    }

    func physicsSetup() {
        airShip.physicsBody = SKPhysicsBody(circleOfRadius: 60)
        airShip.physicsBody?.affectedByGravity = false
        airShip.physicsBody?.allowsRotation = false
        airShip.physicsBody?.contactTestBitMask = 0b0010
        airShip.physicsBody?.collisionBitMask = 0b0001

        crossHair.physicsBody = SKPhysicsBody(circleOfRadius: 40)
        crossHair.physicsBody?.categoryBitMask = 0b0010
        crossHair.physicsBody?.affectedByGravity = false
        crossHair.physicsBody?.isDynamic = false
        self.physicsWorld.contactDelegate = self
    }

}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        crossHair.texture = SKTexture(imageNamed: "crossHairRed")
        crossHair.scale(to: CGSize(width: size.width*0.12, height: size.width*0.12))
        GameScene.isAimLocked = true
        print(GameScene.isAimLocked)
    }

    func didEnd(_ contact: SKPhysicsContact) {
        crossHair.texture = SKTexture(imageNamed: "crossHairGreen")
        crossHair.scale(to: CGSize(width: size.width*0.1, height: size.width*0.1))
        GameScene.isAimLocked = false
        print(GameScene.isAimLocked)
    }
}
