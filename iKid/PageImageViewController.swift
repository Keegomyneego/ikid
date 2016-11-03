//
//  PageImageViewController.swift
//  iKid
//
//  Created by Keegs on 11/3/16.
//  Copyright © 2016 Keegan Farley. All rights reserved.
//

import UIKit

class PageImageViewController: UIViewController, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {

    let flipAnimationController = FlipAnimationController()

    @IBInspectable var image: UIImage?
    @IBInspectable var hideNextButton: Bool = false

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        // Storyboard is tryna initialize me, gotta
        // load in all my niblets :P
        Bundle.main.loadNibNamed("PageImageViewController", owner: self, options: nil)
    }

    //--------------------------------------------------------------------------------
    // IBActions
    //--------------------------------------------------------------------------------

    @IBAction func nextButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "flipToNext", sender: self)
    }

    //--------------------------------------------------------------------------------
    // UIViewController overrides
    //--------------------------------------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()

        // Give the provided image to the preconstrained image view
        imageView?.image = self.image

        // Show / hide next button
        nextButton?.isHidden = self.hideNextButton
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Delegate some navigation controlling logic to this controller
        navigationController?.delegate = flipAnimationController
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
