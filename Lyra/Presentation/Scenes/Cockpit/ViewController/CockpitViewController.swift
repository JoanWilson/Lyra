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
        let myGesture = ThunderGestureRecognizer(target: self, action: #selector(circled))
        subView.addGestureRecognizer(myGesture) //TIRAR DAQ
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
//            subView.backgroundColor = .red
            scene.updateAirShipState()
        }
    }
}







//
//  ThunderGestureRecognizer.swift
//  POC-CustomGesture
//
//  Created by Luiz Sena on 31/03/23.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

enum CheckmarkPhasesThunder {
    case notStarted
    case initialPoint
    case firstDownStroke
    case rightStroke
    case secondDownStroke
}


class ThunderGestureRecognizer: UIGestureRecognizer {

    var strokePhase : CheckmarkPhasesThunder = .notStarted
    var initialTouchPoint : CGPoint = CGPoint.zero
    var trackedTouch : UITouch? = nil

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        if touches.count != 1 {
            self.state = .failed
        }

        // Capture the first touch and store some information about it.
        if self.trackedTouch == nil {
            self.trackedTouch = touches.first
            self.strokePhase = .initialPoint
            self.initialTouchPoint = (self.trackedTouch?.location(in: self.view))!
        } else {
            // Ignore all but the first touch.
            for touch in touches {
                if touch != self.trackedTouch {
                    self.ignore(touch, for: event)
                }
            }
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        let newTouch = touches.first

        // There should be only the first touch.
        guard newTouch == self.trackedTouch else {
            self.state = .failed
            print(#function)
            return
        }
        let newPoint = (newTouch?.location(in: self.view))!
        let previousPoint = (newTouch?.previousLocation(in: self.view))!
        if self.strokePhase == .initialPoint {
            if newPoint.x <= initialTouchPoint.x && newPoint.y >= initialTouchPoint.y {
                self.strokePhase = .firstDownStroke
                print("firstDownStroke")
            } else {         self.state = .failed
            }
        } else if self.strokePhase == .firstDownStroke {
            if newPoint.x >= previousPoint.x {
                if newPoint.y >= previousPoint.y {
                    self.strokePhase = .rightStroke
                    print("rightStroke")
                }
            } else {
//                self.state = .failed
//                print("failed2")
            }
        } else if self.strokePhase == .rightStroke {
            if newPoint.x < previousPoint.x {
                if newPoint.y > previousPoint.y {
                    self.strokePhase = .secondDownStroke
                    print("secondDownStroke")
                }
            } else {
//                self.state = .failed
            }
        } else if self.strokePhase == .secondDownStroke {
            if newPoint.x > previousPoint.x || newPoint.y < previousPoint.y {
                self.state = .failed
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        let newTouch = touches.first
        let newPoint = (newTouch?.location(in: self.view))!
        // There should be only the first touch.
        guard newTouch == self.trackedTouch else {
            self.state = .failed
            return
        }
        // If the stroke was moving up and the final point is
        // above the initial point, the gesture succeeds.
        if self.state == .possible &&
            self.strokePhase == .secondDownStroke &&
            newPoint.y > initialTouchPoint.y {
            self.state = .recognized
        } else {
            self.state = .failed
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        self.initialTouchPoint = CGPoint.zero
        self.strokePhase = .notStarted
        self.trackedTouch = nil
        self.state = .cancelled
    }

    override func reset() {
        super.reset()
        self.initialTouchPoint = CGPoint.zero
        self.strokePhase = .notStarted
        self.trackedTouch = nil
    }
}
