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
import CoreMotion

class ConfettiView: SCNView, SCNSceneRendererDelegate {

    // MARK: - Data Types

    enum ConfettiMode {
        case foreground
        case background
        case both
    }

    // MARK: - Properties

    var confettiMode = ConfettiMode.foreground

    // MARK: - Private Properties

//    private let motionManager = CMMotionManager.init()

    private let confetti = SCNParticleSystem(named: "art.scnassets/Confetti.scnp", inDirectory: nil)!
    private let backgroundConfetti = SCNParticleSystem(named: "art.scnassets/ConfettiBackground.scnp", inDirectory: nil)!

    private var confettiDispenser: SCNNode!
    private var backgroundConfettiDispenser: SCNNode!

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
        //motionManager.startDeviceMotionUpdates()

        switch confettiMode {
        case .foreground:
            confettiDispenser.addParticleSystem(confetti)
        case .background:
            backgroundConfettiDispenser.addParticleSystem(backgroundConfetti)
        case .both:
            confettiDispenser.addParticleSystem(confetti)
            backgroundConfettiDispenser.addParticleSystem(backgroundConfetti)
        }
    }

    // MARK: - Private Functions

    private func setup() {
        scene = SCNScene(named: "art.scnassets/scene.scn")!

        cameraNode = scene!.rootNode.childNode(withName: "Camera", recursively: true)!
        confettiDispenser = scene!.rootNode.childNode(withName: "ConfettiDispenser", recursively: true)!
        backgroundConfettiDispenser = scene!.rootNode.childNode(withName: "BackgroundConfettiDispenser",
                                                               recursively: true)!

        backgroundColor = UIColor.clear

        delegate = self
    }

//    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
//        if let attitude = motionManager.deviceMotion?.attitude {
//            let clampedYaw = max(min(attitude.yaw, Double.pi / 2.0), -Double.pi / 2.0)
//            let x = (clampedYaw / (Double.pi / 2)) * -9.8
//
//            scene.physicsWorld.gravity = SCNVector3(CGFloat(x), -9.8, 0)
//        }
//    }

}
