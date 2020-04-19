//
//  Scene.swift
//  SwiftConfetti
//
//  Created by Connor Power on 13/04/20.
//

import Foundation
import SceneKit

final class ConfettiScene: SCNScene {

    // MARK: - Private Properties

    /**
     A particle system which will dispense a short-lived burst of
     confetti particles when attached to a node. The confetti
     particles will be regular size and in-focus, suitable for
     default use.
     */
    private let confettiForeground = ConfettiParticleSystem(placement: .foreground)

    /**
     A particle system which will dispense a short-lived burst of
     confetti particles when attached to a node. The confetti
     particles will be blurred and slightly smaller than those in
     `confettiForeground`, giving the effect that they are in the
     background.
     */
    private let confettiBackground = ConfettiParticleSystem(placement: .background)

    /**
     A textureless node to which a `ConfettiParticleSystem` can be
     attached. It is placed in front of the camera, just above the
     camera's field of view.
     */
    private lazy var foregroundDispenser: SCNNode! = {
        let node = SCNNode()
        node.name = "ConfettiForegroundDispenser"
        node.position = SCNVector3(0.0, 12.0, -2.0)
        return node
    }()

    /**
     A textureless node to which a `ConfettiParticleSystem` can be
     attached. It is placed in front of the camera, further back
     than `foregroundDispenser` and just above the camera's field
     of view.
     */
    private lazy var backgroundDispenser: SCNNode! = {
        let node = SCNNode()
        node.name = "ConfettiBackgroundDispenser"
        node.position = SCNVector3(0.0, 14.0, -5.0)
        return node
    }()

    /**
     A camera node with attached omnidirectional light.
     */
    private lazy var camera: SCNNode! = {
        let node = SCNNode()
        node.name = "Camera"
        node.position = SCNVector3(0.0, 0.0, 15.0)
        node.camera = {
            let camera = SCNCamera()
            camera.wantsDepthOfField = true
            camera.focalLength = 20.785
            camera.fieldOfView = 60.0
            return camera
        }()

        return node
    }()

    private lazy var directionalLight: SCNNode! = {
        let node = SCNNode()
        node.name = "DirectionalLight"
        node.position = SCNVector3(-22, -1.8, 28)
        node.eulerAngles = SCNVector3(31.0, -38.0, -14.0)

        node.light = {
            let light = SCNLight()
            light.name = "DirectionalLight"
            light.type = .directional
            light.intensity = 1300
            return light
        }()

        return node
    }()

    // MARK: - Initialization

    override init() {
        super.init()
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Functions

    /**
     Dispense confetti applicable for the given placement.

     - parameter placement: If `both`, then both the foreground and
     background dispensers will dispenese the approprite confetti
     particles. If `foreground` or `background`, then only one of
     the dispensers will dispense confetti, respectively.
     */
    public func dispense(placement: ConfettiView.Placement) {
        switch placement {
        case .foreground:
            foregroundDispenser.addParticleSystem(confettiForeground)
        case .background:
            backgroundDispenser.addParticleSystem(confettiBackground)
        case .both:
            foregroundDispenser.addParticleSystem(confettiForeground)
            backgroundDispenser.addParticleSystem(confettiBackground)
        }
    }

    // MARK: - Private Functions

    private func setup() {
        rootNode.addChildNode(backgroundDispenser)
        rootNode.addChildNode(foregroundDispenser)
        rootNode.addChildNode(camera)
        rootNode.addChildNode(directionalLight)
    }

}
