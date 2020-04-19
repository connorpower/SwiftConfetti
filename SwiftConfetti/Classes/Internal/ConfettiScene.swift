//
//  Scene.swift
//  SwiftConfetti
//
//  Created by Connor Power on 13/04/2020.
//  Copyright © 2020 Connor Power. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation
import SceneKit

/**
 A `ConfettiScene` is a SceneKit scene comprising a camera, lighting
 and two slightly out of view nodes from which confetti can be dispensed.
 The camera is positioned so that the nodes from which confetti is
 dispensed are ever so slightly out of view above the top edge of the
 screen which gives the impression that confetti is raining down from
 some out-of-view dispenser above the screen.
 */
final class ConfettiScene: SCNScene {

    // MARK: - Private Properties

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
        let lifeSpan = DispatchTimeInterval.seconds(Int(ConfettiParticleSystem.lifeSpan))

        if placement == .foreground || placement == .both {
            let particleSystem = ConfettiParticleSystem(placement: .foreground)
            foregroundDispenser.addParticleSystem(particleSystem)
            DispatchQueue.main.asyncAfter(deadline: .now() + lifeSpan) { [weak self] in
                self?.foregroundDispenser.removeParticleSystem(particleSystem)
            }
        }

        if placement == .background || placement == .both {
            let particleSystem = ConfettiParticleSystem(placement: .background)
            backgroundDispenser.addParticleSystem(particleSystem)
            DispatchQueue.main.asyncAfter(deadline: .now() + lifeSpan) { [weak self] in
                self?.backgroundDispenser.removeParticleSystem(particleSystem)
            }
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
