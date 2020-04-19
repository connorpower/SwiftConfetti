//
//  Scene.swift
//  SwiftConfetti
//
//  Created by Connor Power on 13/04/20.
//

import Foundation
import SceneKit

final class ConfettiScene: SCNScene {

    // MARK: - Properties

    lazy var backgroundDispenser: SCNNode! = {
        let node = SCNNode()
        node.name = "ConfettiBackgroundDispenser"
        node.position = SCNVector3(0.0, 14.0, -5.0)
        return node
    }()

    lazy var foregroundDispenser: SCNNode! = {
        let node = SCNNode()
        node.name = "ConfettiForegroundDispenser"
        node.position = SCNVector3(0.0, 12.0, -2.0)
        return node
    }()

    lazy var camera: SCNNode! = {
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

    lazy var directionalLight: SCNNode! = {
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

    private func setup() {
        rootNode.addChildNode(backgroundDispenser)
        rootNode.addChildNode(foregroundDispenser)
        rootNode.addChildNode(camera)
        rootNode.addChildNode(directionalLight)
    }

}
