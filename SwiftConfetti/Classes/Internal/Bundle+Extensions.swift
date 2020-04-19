//
//  Bundle+Extensions.swift
//  SwiftConfetti
//
//  Created by Connor Power on 13/04/20.
//

import Foundation

extension Bundle {
    /**
     Returns the bundle for the `SwiftConfetti` framework to allow
     loading embedded resources.
     */
    static let frameworkBundle = Bundle(for: ConfettiView.self)
}
