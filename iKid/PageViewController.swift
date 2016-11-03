//
//  PageViewController.swift
//  iKid
//
//  Created by Keegs on 11/3/16.
//  Copyright © 2016 Keegan Farley. All rights reserved.
//

import UIKit

class PageViewController: UIViewController, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {

    let flipAnimationController = FlipAnimationController()

    //--------------------------------------------------------------------------------
    // UIViewController overrides
    //--------------------------------------------------------------------------------

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Delegate some navigation controlling logic to this controller
        navigationController?.delegate = self
    }

    //--------------------------------------------------------------------------------
    // UINavigationControllerDelegate overrides
    //--------------------------------------------------------------------------------

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        // Set flip direction
        flipAnimationController.operation = operation

        return flipAnimationController
    }
}

