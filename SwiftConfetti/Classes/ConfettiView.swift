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

/**
 A `ConfettiView` is a full view which dispenses confetti over the top
 of any contents placed behind it. The `ConfettiView` is transparent
 and doesn't respond to touches, so it can be placed at in front of
 all other content and pinned to all edges of a `UIViewController`.

 Either a single `ConfettiView` can be used or a pair of them - one
 in the foreground placed over all other content and one behind content
 for a genuine 3D confetti effect. The `ConfettiView` placed behind
 content should have it's `placement` property set to `background` which
 will cause it to dispense slightly smaller, blurred confetti images
 appropriate for background confetti. When combined with another
 `foreground` `ConfettiView` placed in front of all content (highest
 z-index), a truly immersive confetti effect can be achieved.

 The confetti effect is rendered using `Metal` - Apple's high performance
 GPU renderer.
 */
public class ConfettiView: UIView {

    // MARK: - Data Types

    /**
     Defines the placement for a `ConfettiView`. For normal use case,
     set this to `foreground`. For a fully immersive confetti effect,
     configure two `ConfettiView`s - one placed in front of all other
     UI content, and the other behind all other UI content.
     */
    public enum Placement {
        /**
         The default placement which should be used when using only a
         single `ConfettiView`. This placement will cause the single
         `ConfettiView` to dispense all the confetti instead of the more
         immersive effect which can be used when splitting the confetti
         across a `foreground` and a `background` ConfettiView which
         provides an imemrsive effect where it looks as though confetti
         is raining down throughout UI elements in full 3D space.
         */
        case `default`

        /**
         Configures the `ConfettiView` for a foreground position (i.e.
         when it is placed on top of all other UI content). This should
         only be used when using two `ConfettiView`s (with one view set
         to `foreground` and the other set to `background`).
         */
        case foreground

        /**
         Configures the `ConfettiView` for a background position (i.e.
         when it is placed behind all other UI content). This should
         only be used when using two `ConfettiView`s (with one view set
         to `foreground` and the other set to `background`).
         */
        case background
    }

    // MARK: - Constants

    /**
     A notification name, which when observed by a `ConfettiView`, triggers
     confetti to be dispensed.

     ```swift
     NotificationCenter.default.post(name: ConfettiView.DispenseConfettiNotification, object: nil)
     ```

     Calling the method `confettiView.dispense()` will also trigger confetti,
     but the using a notification can be very useful. Generally, `ConfettiView`s
     should be added to the view heirarchy — one above all content and one beneath
     all content.

     ```
     [Top ConfettiView]
     [UINavigationController]
         [Visible ViewController]
     [Bottom ConfettiView]
     ```

     In the above situation, it can be very difficult for the visible view controller
     to directly invoke `topConfettiView.dispense()` and `bottomConfettiView.dispense()`
     because they are not part of it's view heirarchy and it doesn't have any
     references to them. In this case, the visiable view controller can simply post
     a `ConfettiView.DispenseConfettiNotification` and the two dispensers will react
     appropriately.
     */
    public static let DispenseConfettiNotification =
        Notification.Name("com.connorpower.SwiftConfetti.dispense")

    // MARK: - Properties

    /**
     Configures the placement of the `ConfettiView`.
     */
    public var placement = Placement.default

    /**
     Indicates whether the `ConfettiView` should provide a strong haptic
     thump similar to Apple Messages when confetti is dispensed. This effect
     will only work on a physical device.
     */
    public var provideHapticThump = true

    // MARK: - Private Properties

    private lazy var sceneView: SCNView! = {
        let options: [String: NSNumber] = [
            SCNView.Option.preferLowPowerDevice.rawValue : NSNumber(booleanLiteral: true),
            SCNView.Option.preferredDevice.rawValue: NSNumber(value: SCNRenderingAPI.metal.rawValue)
        ]
        return SCNView(frame: .zero, options: options)
    }()

    private let confettiScene = ConfettiScene()

    private var dispenseNoficationObserver: Any?

    // MARK: - Initialization

    /**
     Creates a new `ConfettiView`.
     */
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    /**
     Creates a new `ConfettiView`.
     */
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    deinit {
        if let observer = dispenseNoficationObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }

    // MARK: - Functions

    /**
     Dispense confetti. This function can be called multiple times in
     quick succession which will cause a layering of confetti effects.
     */
    public func dispense() {
        if provideHapticThump {
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        }
        confettiScene.dispense(placement: placement)
    }

    // MARK: - Private Functions

    private func setup() {
        configureScene()
        observeNotifications()

        isUserInteractionEnabled = false
        backgroundColor = UIColor.clear
    }

    private func configureScene() {
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
    }

    private func observeNotifications() {
        dispenseNoficationObserver = NotificationCenter.default.addObserver(
            forName: ConfettiView.DispenseConfettiNotification,
            object: nil,
            queue: .main) { [weak self] _ in self?.dispense() }
    }

}
