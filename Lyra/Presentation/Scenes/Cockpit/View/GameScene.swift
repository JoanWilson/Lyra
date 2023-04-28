//
//  GameScene.swift
//  Lyra
//
//  Created by Luiz Sena on 10/04/23.
//

import UIKit
import SpriteKit
import SwiftUI

enum TypeRune {
    case Sowilu
    case Kauna
    case Uruz
}

struct EnemyAirship {
    let id = UUID()
    var name: String
    var rune: TypeRune
    var path: UIBezierPath?
}


class GameScene: SKScene {

    let background = SKSpriteNode(imageNamed: "battleBackground")
    let cockpit = SKSpriteNode(imageNamed: "cockpit")
//    let airShip = SKSpriteNode(imageNamed: "enemySpaceship")
    let crossHair = SKSpriteNode(imageNamed: "crossHairGreen")
    lazy var  airshipEnemies: [EnemyAirship] = [
        EnemyAirship(name: "1", rune: .Kauna, path: randomPath(UIBezierPath())),
        EnemyAirship(name: "2", rune: .Sowilu, path: randomPath(UIBezierPath())),
        EnemyAirship(name: "3", rune: .Uruz, path: randomPath(UIBezierPath())),
    ]
    
    static public var isAimLocked: TypeRune? = nil
    static public var currentNodeLocked: SKNode = SKNode()

    override func didMove(to view: SKView) {
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.zPosition = -2
        cockpit.zPosition = 0
//        airShip.zPosition = -1
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
//        self.addChild(airShip)
        self.addChild(crossHair)
//        foreverActions()
//        addAirShips()
    }
    
    

    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
//        airShip.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//        airShip.position = CGPoint(x: frame.midX, y: frame.midY)
//        airShip.scale(to: CGSize(width: size.width*0.2, height: size.height*0.2))
//        configureMovement()
        //        airShip.texture = SKTexture(imageNamed: "rune")
     
        crossHair.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        crossHair.position = CGPoint(x: frame.midX, y: frame.midY)
        crossHair.scale(to: CGSize(width: size.width*0.2, height: size.width*0.2))
        crossHair.name = "crossHair"

        addAirShips()
    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        guard let touch = touches.first else { return }
//        let location = touch.location(in: self)
//        airShip.run(SKAction.move(to: location, duration: 1))
//    }
    
    var noAirships = true
    func addAirShips() {
        guard noAirships else { return }
        
        for airShipEnemy in airshipEnemies {
            var airShip = SKSpriteNode()
            switch airShipEnemy.rune {
            case .Kauna:
                airShip = SKSpriteNode(imageNamed: "enemyKauna")
            case .Sowilu:
                airShip = SKSpriteNode(imageNamed: "enemySowilu")
            case .Uruz:
                airShip = SKSpriteNode(imageNamed: "enemyUruz")
            }
            
            airShip.name = airShipEnemy.name
            airShip.zPosition = -1
            airShip.physicsBody = SKPhysicsBody(circleOfRadius: 60)
            airShip.physicsBody?.affectedByGravity = false
            airShip.physicsBody?.allowsRotation = false
//            airShip.physicsBody?.isDynamic = false
            airShip.physicsBody?.contactTestBitMask = 0b0010
            airShip.physicsBody?.collisionBitMask = 0b0001
            
            self.addChild(airShip)
            
            airShip.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            airShip.position = CGPoint(x: frame.midX, y: frame.midY)
            airShip.scale(to: CGSize(width: size.width*0.2, height: size.height*0.3))
            
            configureMovement(airShip)
        }
        noAirships = false
    }
    
    
    func foreverActions(_ airShip: SKSpriteNode) {
        let distance = CGFloat(150.0) // The distance to move the node to the left and right
        let duration = TimeInterval(2.0) // The duration for each movement

        // Create the actions to move the node to the right and left
        let moveRight = SKAction.moveBy(x: distance, y: 0, duration: duration)
        let moveLeft = SKAction.moveBy(x: -distance, y: 0, duration: duration)

        // Create the sequence to move the node back and forth
        let moveSequence = SKAction.sequence([moveLeft, moveRight])

        // Repeat the sequence forever
        let repeatForever = SKAction.repeatForever(moveSequence)

        // Apply the action to the node
        airShip.run(repeatForever)
    }
    
    func updateAirShipState(_ skNode: SKNode) {
        skNode.removeFromParent()
        crossHair.texture = SKTexture(imageNamed: "crossHairGreen")
        crossHair.scale(to: CGSize(width: size.width*0.1, height: size.width*0.1))
    }

    func physicsSetup() {
//        airShip.physicsBody = SKPhysicsBody(circleOfRadius: 60)
//        airShip.physicsBody?.affectedByGravity = false
//        airShip.physicsBody?.allowsRotation = false
//        airShip.physicsBody?.contactTestBitMask = 0b0010
//        airShip.physicsBody?.collisionBitMask = 0b0001

        crossHair.physicsBody = SKPhysicsBody(circleOfRadius: 40)
        crossHair.physicsBody?.categoryBitMask = 0b0010
        crossHair.physicsBody?.affectedByGravity = false
        crossHair.physicsBody?.isDynamic = false
        self.physicsWorld.contactDelegate = self
    }

    func configureMovement(_ airShip: SKSpriteNode) {
        let path = UIBezierPath()
        let startPoint = CGPoint(x: frame.midX, y: frame.midY)
        path.move(to: startPoint)
        lazy var randomPath = randomPath(path)
        let move = SKAction.follow(randomPath.cgPath, asOffset: false, orientToPath: false, duration: 10.0)
        airShip.run(SKAction.repeat(move, count: 1000000))
    }

    func randomPath(_ path: UIBezierPath) -> UIBezierPath {
        let controlPoint = CGPoint(
            x: frame.width/10 * CGFloat.random(in: 1...9),
            y: frame.height/10 * CGFloat.random(in: 2...7)
        )
        let controlPoint2 = CGPoint(
            x: frame.width/10 * CGFloat.random(in: 1...9),
            y: frame.height/10 * CGFloat.random(in: 2...7)
        )
        let controlPoint3 = CGPoint(
            x: frame.width/10 * CGFloat.random(in: 1...9),
            y: frame.height/10 * CGFloat.random(in: 2...7)
        )
        let controlPoint4 = CGPoint(
            x: frame.width/10 * CGFloat.random(in: 1...9),
            y: frame.height/10 * CGFloat.random(in: 2...7)
        )
        let centerPoint = CGPoint(
            x: frame.midX,
            y: frame.midY
        )
        let endPoint = CGPoint(
            x: frame.width/10 * CGFloat.random(in: 1...9),
            y: frame.height/10 * CGFloat.random(in: 1...9)
        )
        let endPoint2 = CGPoint(
            x: frame.width/10 * CGFloat.random(in: 1...9),
            y: frame.height/10 * CGFloat.random(in: 1...9)
        )
        
        path.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        path.addQuadCurve(to: centerPoint, controlPoint: controlPoint2)
        path.addQuadCurve(to: endPoint2, controlPoint: controlPoint3)
        path.addQuadCurve(to: centerPoint, controlPoint: controlPoint4)
        return path
    }

}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        crossHair.texture = SKTexture(imageNamed: "crossHairRed")
        crossHair.scale(to: CGSize(width: size.width*0.12, height: size.width*0.12))
        if contact.bodyB.node?.name == "crossHair" {
            switch contact.bodyA.node?.name {
            case "1":
                GameScene.isAimLocked = .Kauna
            case "2":
                GameScene.isAimLocked = .Sowilu
            case "3":
                GameScene.isAimLocked = .Uruz
            default:
                GameScene.isAimLocked = nil
            }
            GameScene.currentNodeLocked = contact.bodyA.node ?? SKNode()
        }
    }

    func didEnd(_ contact: SKPhysicsContact) {
        crossHair.texture = SKTexture(imageNamed: "crossHairGreen")
        crossHair.scale(to: CGSize(width: size.width*0.1, height: size.width*0.1))
        GameScene.isAimLocked = nil
    }
}
