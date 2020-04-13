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

public final class ConfettiView: SCNView {

    // MARK: - Data Types

    public enum ConfettiMode {
        case foreground
        case background
        case both
    }

    // MARK: - Properties

    public var confettiMode = ConfettiMode.foreground

    // MARK: - Private Properties

    private let confettiForeground = ConfettiParticle(placement: .foreground)
    private let confettiBackground = ConfettiParticle(placement: .background)
    private let confettiScene = Scene()

    // MARK: - Initialization

    public override init(frame: CGRect, options: [String : Any]? = nil) {
        super.init(frame: frame, options: options)
        setup()
    }

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
        isUserInteractionEnabled = false
        scene = confettiScene
        backgroundColor = UIColor.clear
    }

}
