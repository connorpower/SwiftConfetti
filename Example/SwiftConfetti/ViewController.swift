//
//  ViewController.swift
//  SwiftConfetti
//
//  Created by Connor Power on 04/12/2020.
//  Copyright (c) 2020 Connor Power. All rights reserved.
//

import UIKit
import SwiftConfetti

class ViewController: UIViewController {

    @IBOutlet private weak var backgroundDispenser: ConfettiView! {
        didSet {
            backgroundDispenser.placement = .background
        }
    }

    @IBOutlet weak var foregroundDispenser: ConfettiView! {
        didSet {
            foregroundDispenser.placement = .foreground
        }
    }

    @IBAction func dispenseConfetti(_ sender: Any) {
        NotificationCenter.default.post(name: ConfettiView.DispenseConfettiNotification, object: nil)
    }

}
