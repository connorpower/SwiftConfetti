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

    // MARK: - Properties

    private var confettiView = ConfettiView(frame: .zero)

    lazy private var button: UIButton! = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("Dispense Confetti", comment: "Button title"), for: .normal)
        button.addTarget(self, action: #selector(self.showConfetti), for: .touchUpInside)
        return button
    }()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    // MARK: - Private Functioons

    private func setup() {
        view.addSubview(button)
        view.addSubview(confettiView)

        button.translatesAutoresizingMaskIntoConstraints = false
        confettiView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            confettiView.leftAnchor.constraint(equalTo: view.leftAnchor),
            confettiView.rightAnchor.constraint(equalTo: view.rightAnchor),
            confettiView.topAnchor.constraint(equalTo: view.topAnchor),
            confettiView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func showConfetti() {
        confettiView.dispense()
    }

}
