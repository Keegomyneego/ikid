//
//  FlipAnimationController.swift
//  iKid
//
//  Created by Keegs on 11/3/16.
//  Copyright © 2016 Keegan Farley. All rights reserved.
//

import UIKit
import Foundation

class FlipAnimationController : NSObject, UIViewControllerAnimatedTransitioning, UINavigationControllerDelegate {

    var operation: UINavigationControllerOperation?

    enum Direction {
        case Forward
        case Backward
    }

    private var direction: Direction {
        return (operation ?? .push) == .push
            ? .Forward
            : .Backward
    }

    private var flipTransition: UIViewAnimationOptions {
        switch self.direction {
        case .Forward:  return .transitionFlipFromRight
        case .Backward: return .transitionFlipFromLeft
        }
    }

    //--------------------------------------------------------------------------------
    // UIViewControllerAnimatedTransitioning overrides
    //--------------------------------------------------------------------------------

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        switch direction {
        case .Forward: return 0.5
        case .Backward: return 0.25
        }
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!.view!
        let toView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!.view!

        print("\n- starting transition")
        UIView.transition(
            from: fromView,
            to: toView,
            duration: self.transitionDuration(using: transitionContext),
            options: flipTransition,
            completion: {
                finished in
                print("\n- finished transition")
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        )
    }

    //--------------------------------------------------------------------------------
    // UINavigationControllerDelegate overrides
    //--------------------------------------------------------------------------------

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        // Set flip direction
        self.operation = operation

        return self
    }
}
