//
//  ForegroundParticleSysytem.swift
//  SwiftConfetti
//
//  Created by Connor Power on 12/04/20.
//

import Foundation
import SceneKit

class ForegroundParticle: SCNParticleSystem {

    struct Constants {
        static let foregroundConfettiImageName = "ConfettiForeground"
        static let backgroundConfettiImageName = "ConfettiBackground"
    }

    override init() {
        super.init()
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        birthRate = 500
        birthRateVariation = 0
        warmupDuration = 0

        isLocal = false
        birthLocation = .surface
        birthDirection = .constant
        emittingDirection = SCNVector3(0.0, -1.0, 0.0)
        spreadingAngle = 180.0
        particleAngle = 180.0
        particleAngleVariation = 45.0
        emitterShape = SCNPlane(width: 15.0, height: 5.0)

        particleLifeSpan = 20.0
        particleLifeSpanVariation = 0.0
        particleVelocity = 5.0
        particleVelocityVariation = 10.0
        particleAngularVelocity = 300.0
        particleAngularVelocityVariation = 90.0
        acceleration = SCNVector3(0.0, 0.0, 0.0)
        speedFactor = 1.0
        stretchFactor = 0.0
        particleImage = UIImage(named: Constants.foregroundConfettiImageName,
                                in: Bundle.frameworkBundle,
                                compatibleWith: nil)
        particleColor = .red
        particleSize = 0.16
        particleSizeVariation = 0.0
        particleIntensity = 1.0
        particleIntensityVariation = 0.0


        let hueVariation: CGFloat = 180.0
        let saturationVariation: CGFloat = 0.1
        let brightnessVariation: CGFloat = 0.1
        let alphaVariation: CGFloat = 0.0

        particleColorVariation = SCNVector4(hueVariation,
                                            saturationVariation,
                                            brightnessVariation,
                                            alphaVariation)

        imageSequenceAnimationMode = .repeat

        isAffectedByGravity = true
        particleMass = 5.0
        particleMassVariation = 1.0
        particleBounce = 0.7
        particleFriction = 1.0
        dampingFactor = 0.2

        emissionDuration = 0.5
        loops = false
    }
}

