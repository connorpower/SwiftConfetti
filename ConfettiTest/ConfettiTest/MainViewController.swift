//
//  MainViewController.swift
//  ConfettiTest
//
//  Created by Connor Power on 25/12/2018.
//  Copyright © 2018 Teleportr. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class MainViewController: UIViewController {

    @IBOutlet weak var backgroundConfettiView: ConfettiView!
    @IBOutlet weak var foregroundConfettiView: ConfettiView!

    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundConfettiView.confettiMode = .background
        foregroundConfettiView.confettiMode = .foreground

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        backgroundConfettiView.dispense()
        foregroundConfettiView.dispense()
    }

}

