//
//  ConfettiParticle.swift
//  SwiftConfetti
//
//  Created by Connor Power on 12/04/20.
//

import Foundation
import SceneKit

class ConfettiParticle: SCNParticleSystem {

    // MARK: - Data Types

    enum Placement {
        case foreground
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
    }

    private func customizeForPlacement() {
        let config = self.placement.configuration
        birthRate = config.birthRate
        spreadingAngle = config.spreadingAngle
        particleImage = config.particleImage
        particleSize = config.particleSize
    }

}

