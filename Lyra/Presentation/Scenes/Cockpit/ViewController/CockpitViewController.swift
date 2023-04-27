//
//  CockpitViewController.swift
//  Lyra
//
//  Created by Luiz Sena on 10/04/23.
//
 
import UIKit
import SpriteKit

protocol MoveToLevelView {
    func moveToLevelView()
}

class CockpitViewController: UIViewController {
    
    var moveToLevelViewDelegate: MoveToLevelView!

    let scene: GameScene = GameScene(size: UIScreen.main.bounds.size)
    var showingLevelView: Bool = false
    var numberOfAirShipsToDestroy: Int = 5 {
        didSet {
            if self.numberOfAirShipsToDestroy == 0 {
                moveToLevelViewDelegate.moveToLevelView()
            }
            numberOfAirShip.text = "X \(self.numberOfAirShipsToDestroy)"
        }
    }
    
    lazy var skView: SKView = {
        let view = SKView()
        return view
    }()
    
    lazy var smallAirShipLabel: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "enemySpaceship")
        
        return imageView
    }()

    lazy var subView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.opacity = 0.3
        return view
    }()
    
    lazy var numberOfAirShip: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "X \(scene.children.count - 3)"
        label.font = .systemFont(ofSize: 30, weight: .bold)
    
        return label
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
        self.skView.addSubview(numberOfAirShip)
        self.skView.addSubview(smallAirShipLabel)
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            subView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height*0.7),
            subView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*0.3),
            subView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            subView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            
            
            smallAirShipLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            smallAirShipLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            smallAirShipLabel.heightAnchor.constraint(equalToConstant: 70),
            smallAirShipLabel.widthAnchor.constraint(equalToConstant: 100),
            
            numberOfAirShip.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            numberOfAirShip.leadingAnchor.constraint(equalTo: smallAirShipLabel.trailingAnchor),
        ])
    }

    @objc func sowiluHandler(_ c: UIGestureRecognizer) {
        if c.state == .recognized {
            if GameScene.isAimLocked == .Sowilu {
                scene.updateAirShipState(GameScene.currentNodeLocked)
                fetchNumberOfCurrentShips()
            }
        }
    }
    @objc func kaunaHandler(_ c: UIGestureRecognizer) {
        if c.state == .recognized {
            if GameScene.isAimLocked == .Kauna {
                scene.updateAirShipState(GameScene.currentNodeLocked)
                fetchNumberOfCurrentShips()
            }
        }
    }
    @objc func uruzHandler(_ c: UIGestureRecognizer) {
        if c.state == .recognized {
            if GameScene.isAimLocked == .Uruz {
                scene.updateAirShipState(GameScene.currentNodeLocked)
                fetchNumberOfCurrentShips()
            }
        }
    }
    
    func fetchNumberOfCurrentShips() {
        self.numberOfAirShipsToDestroy = scene.children.count - 3
    }
}
