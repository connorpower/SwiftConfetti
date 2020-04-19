//
//  ConfettiParticleSystem.swift
//  SwiftConfetti
//
//  Created by Connor Power on 12/04/2020.
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
 `ConfettiParticleSystem` is a SceneKit particle system which creates a
 short-lived confetti effect. It should be attached to the scene
 each time confetti should be dispensed.

 Two modes exist - `foreground` and `background`. The `foreground`
 mode dispenses confetti particles as they might be expected to look.
 The `background` mode dispenses smaller, blurred confetti particles
 which give the effect of being somewhat far away in the distance.
 */
final class ConfettiParticleSystem: SCNParticleSystem {

    // MARK: - Data Types

    /**
     A `Placement` dictates particle systems visual style. The `foreground`
     mode dispenses confetti particles as they might be expected to look.
     The `background` mode dispenses smaller, blurred confetti particles
     which give the effect of being somewhat far away in the distance.
     */
    enum Placement {
        /**
         Crisp, regular-sized confetti particles. If only one particle system
         is used, then `foreground` should be used as the default.
         */
        case foreground

        /**
         Slightly smaller, blurred confetti particles which give the
         appearance of being further in the background relative to
         `foreground`.
         */
        case background

        fileprivate var configuration: Configuration {
            switch self {
            case .foreground:
                let image = UIImage(named: "ConfettiForeground",
                                    in: Bundle.frameworkBundle,
                                    compatibleWith: nil)!
                return .init(birthRate: 500,
                             spreadingAngle: 180.0,
                             particleImage: image,
                             particleSize: 0.16)
            case .background:
                let image = UIImage(named: "ConfettiBackground",
                                    in: Bundle.frameworkBundle,
                                    compatibleWith: nil)!
                return .init(birthRate: 700,
                             spreadingAngle: 45.0,
                             particleImage: image,
                             particleSize: 0.13)
            }
        }
    }

    fileprivate struct Configuration {
        let birthRate: CGFloat
        let spreadingAngle: CGFloat
        let particleImage: UIImage
        let particleSize: CGFloat
    }

    // MARK: - Properties

    let placement: Placement

    // MARK: - Initialization

    /**
     Creates a new `ConfettiParticleSystem` to be added to a SceneKit scene.
     Each time confetti is dispensed, a new `ConfettiParticleSystem` should
     be created nd attached.

     - parameter placement: Configures the particle system's visual properties
     for a given placement.
     */
    required init(placement: Placement) {
        self.placement = placement
        super.init()
        setupDefaults()
        customizeForPlacement()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Functions

    private func setupDefaults() {
        emittingDirection = SCNVector3(0.0, -1.0, 0.0)
        particleAngle = 180.0
        spreadingAngle = 180.0
        particleAngleVariation = 45.0
        emitterShape = SCNPlane(width: 15.0, height: 5.0)

        particleLifeSpan = 20.0
        particleVelocity = 5.0
        particleVelocityVariation = 10.0
        particleAngularVelocity = 300.0
        particleAngularVelocityVariation = 90.0
        particleColor = .red

        let hueVariation: CGFloat = 180.0
        let saturationVariation: CGFloat = 0.1
        let brightnessVariation: CGFloat = 0.1
        let alphaVariation: CGFloat = 0.0
        particleColorVariation = SCNVector4(hueVariation,
                                            saturationVariation,
                                            brightnessVariation,
                                            alphaVariation)

        isAffectedByGravity = true
        particleMass = 5.0
        particleMassVariation = 1.0
        particleBounce = 0.7
        particleFriction = 1.0
        dampingFactor = 0.2

        emissionDuration = 0.5
        loops = false

        isLightingEnabled = true
        sortingMode = .distance
        blendMode = .alpha
        orientationMode = .free
    }

    private func customizeForPlacement() {
        let config = self.placement.configuration
        birthRate = config.birthRate
        spreadingAngle = config.spreadingAngle
        particleImage = config.particleImage
        particleSize = config.particleSize
    }

}
