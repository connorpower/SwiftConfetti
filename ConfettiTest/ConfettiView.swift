//
//  ConfettiView.swift
//  ConfettiTest
//
//  Created by Connor Power on 26/12/2018.
//  Copyright © 2018 Teleportr. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class ConfettiView: SCNView {

    // MARK: - Data Types

    enum ConfettiMode {
        case foreground
        case background
        case both
    }

    // MARK: - Properties

    var confettiMode = ConfettiMode.foreground

    // MARK: - Private Properties

    private let confettiForeground = SCNParticleSystem(named: "Confetti.scnassets/ConfettiForeground.scnp",
                                                       inDirectory: nil)!
    private let confettiBackground = SCNParticleSystem(named: "Confetti.scnassets/ConfettiBackground.scnp",
                                                       inDirectory: nil)!

    private var confettiForegroundDispenser: SCNNode!
    private var confettiBackgroundDispenser: SCNNode!

    private var cameraNode: SCNNode!

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Functions

    func dispense() {
        switch confettiMode {
        case .foreground:
            confettiForegroundDispenser.addParticleSystem(confettiForeground)
        case .background:
            confettiBackgroundDispenser.addParticleSystem(confettiBackground)
        case .both:
            confettiForegroundDispenser.addParticleSystem(confettiForeground)
            confettiBackgroundDispenser.addParticleSystem(confettiBackground)
        }
    }

    // MARK: - Private Functions

    private func setup() {
        scene = SCNScene(named: "Confetti.scnassets/scene.scn")!

        cameraNode = scene!.rootNode.childNode(withName: "Camera", recursively: true)!
        confettiForegroundDispenser = scene!.rootNode.childNode(withName: "ConfettiForegroundDispenser",
                                                                recursively: true)!
        confettiBackgroundDispenser = scene!.rootNode.childNode(withName: "ConfettiBackgroundDispenser",
                                                                recursively: true)!

        backgroundColor = UIColor.clear
    }

}
