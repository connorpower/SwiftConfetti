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

public class ConfettiView: UIView {

    // MARK: - Data Types

    public enum ConfettiMode {
        case foreground
        case background
        case both
    }

    // MARK: - Properties

    public var confettiMode = ConfettiMode.foreground

    private lazy var sceneView: SCNView! = {
        let options: [String: NSNumber] = [
            SCNView.Option.preferLowPowerDevice.rawValue : NSNumber(booleanLiteral: true),
            SCNView.Option.preferredDevice.rawValue: NSNumber(value: SCNRenderingAPI.metal.rawValue)
        ]
        return SCNView(frame: .zero, options: options)
    }()

    // MARK: - Private Properties

    private let confettiForeground = ConfettiParticle(placement: .foreground)
    private let confettiBackground = ConfettiParticle(placement: .background)
    private let confettiScene = Scene()

    // MARK: - Initialization

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Functions

    public func dispense() {
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()

        switch confettiMode {
        case .foreground:
            confettiScene.foregroundDispenser.addParticleSystem(confettiForeground)
        case .background:
           confettiScene.backgroundDispenser.addParticleSystem(confettiBackground)
        case .both:
            confettiScene.foregroundDispenser.addParticleSystem(confettiForeground)
            confettiScene.backgroundDispenser.addParticleSystem(confettiBackground)
        }
    }

    // MARK: - Private Functions

    private func setup() {
        sceneView.scene = confettiScene
        sceneView.autoenablesDefaultLighting = false

        addSubview(sceneView)
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sceneView.topAnchor.constraint(equalTo: topAnchor),
            sceneView.bottomAnchor.constraint(equalTo: bottomAnchor),
            sceneView.leftAnchor.constraint(equalTo: leftAnchor),
            sceneView.rightAnchor.constraint(equalTo: rightAnchor)
        ])

        sceneView.isUserInteractionEnabled = false
        sceneView.backgroundColor = UIColor.clear

        isUserInteractionEnabled = false
        backgroundColor = UIColor.clear
    }

}
