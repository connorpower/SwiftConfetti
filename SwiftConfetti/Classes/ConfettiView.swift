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

    // MARK: - Constants

    private struct Resources {
        static let sceneURL = Bundle.frameworkBundle.url(forResource: "Confetti.scnassets/scene", withExtension: "scn")!
    }

    private struct NodeNames {
        static let camera = "Camera"
        static let foregroundDispenser = "ConfettiForegroundDispenser"
        static let backgroundDispenser = "ConfettiForegroundDispenser"
    }

    // MARK: - Properties

    public var confettiMode = ConfettiMode.foreground

    // MARK: - Private Properties

//    private let confettiForeground = SCNParticleSystem(named: Resources.foregroundParticlesFileName,
//                                                       inDirectory: Resources.resourceDirectory)!
//    private let confettiBackground = SCNParticleSystem(named: Resources.foregroundParticlesFileName,
//                                                       inDirectory: Resources.resourceDirectory)!


    private let confettiForeground = ForegroundParticle()
    private let confettiBackground = ForegroundParticle()

    private var confettiForegroundDispenser: SCNNode!
    private var confettiBackgroundDispenser: SCNNode!

    private var cameraNode: SCNNode!

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
        isUserInteractionEnabled = false

        scene = try! SCNScene(url: Resources.sceneURL)

        cameraNode = scene!.rootNode.childNode(withName: NodeNames.camera, recursively: true)!
        confettiForegroundDispenser = scene!.rootNode.childNode(withName: NodeNames.foregroundDispenser,
                                                                recursively: true)!
        confettiBackgroundDispenser = scene!.rootNode.childNode(withName: NodeNames.backgroundDispenser,
                                                                recursively: true)!

        backgroundColor = UIColor.clear
    }

}
