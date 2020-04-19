//
//  ConfettiView.swift
//  ConfettiTest
//
//  Created by Connor Power on 26/12/2018.
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

import UIKit
import QuartzCore
import SceneKit

public class ConfettiView: UIView {

    // MARK: - Data Types

    public enum Placement {
        case foreground
        case background
        case both
    }

    // MARK: - Properties

    public var placement = Placement.foreground

    private lazy var sceneView: SCNView! = {
        let options: [String: NSNumber] = [
            SCNView.Option.preferLowPowerDevice.rawValue : NSNumber(booleanLiteral: true),
            SCNView.Option.preferredDevice.rawValue: NSNumber(value: SCNRenderingAPI.metal.rawValue)
        ]
        return SCNView(frame: .zero, options: options)
    }()

    // MARK: - Private Properties

    private let confettiScene = ConfettiScene()

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
        confettiScene.dispense(placement: placement)
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
