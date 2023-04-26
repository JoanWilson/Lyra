//
//  KaunaGesture.swift
//  Lyra
//
//  Created by Luiz Sena on 25/04/23.
//

import Foundation
import UIKit
import UIKit.UIGestureRecognizerSubclass

enum CheckmarkPhasesKauna {
    case notStarted
    case initialPoint
    case leftDownStroke
    case rightDownStroke
}


class KaunaGestureRecognizer: UIGestureRecognizer {

    var strokePhase : CheckmarkPhasesKauna = .notStarted
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

            if newPoint.x < initialTouchPoint.x && newPoint.y > initialTouchPoint.y {
                self.strokePhase = .leftDownStroke
                print("leftDown")
            } else {
                self.state = .failed
            }
        } else if self.strokePhase == .leftDownStroke {
            if newPoint.x > previousPoint.x {
                if newPoint.y > previousPoint.y {
                    self.strokePhase = .rightDownStroke
                    print("rightDown")
                }
            } else {
//                self.state = .failed
//                print("failed2")
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
            self.strokePhase == .rightDownStroke &&
            newPoint.y > initialTouchPoint.y {
            self.state = .recognized
            print("recognized")
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
