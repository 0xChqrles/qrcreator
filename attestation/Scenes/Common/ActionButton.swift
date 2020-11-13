//
//  BottomButton.swift
//  attestation
//
//  Created by Charles Lanier on 10/11/2020.
//

import UIKit

@IBDesignable
class ActionButton: UIButton {

	// MARK: - Public Properties
	var characterSpacing: CGFloat! = 0.0 {
		didSet {
			applyKerning()
		}
	}
	var cornerRadius: CGFloat = 0.0 {
		didSet {
			layer.cornerRadius = cornerRadius
			layer.masksToBounds = cornerRadius > 0
		}
	}

	// MARK: - Initialization
	override init(frame: CGRect) {
		super.init(frame: frame)
		customInit()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		customInit()
	}

	private func customInit() {
		// Shape
		cornerRadius = 8.0

		// Colors
		backgroundColor = UIColor(named: "AccentColor")
		tintColor = .white

		// Title
		characterSpacing = 2.0
		titleLabel?.font = UIFont.actionButtonFont

		// Constraints
		heightAnchor.constraint(equalToConstant: 50).isActive = true
		widthAnchor.constraint(equalToConstant: 200).isActive = true
	}

	override func setTitle(_ title: String?, for state: UIControl.State) {
		super.setTitle(title, for: state)
		applyKerning()
	}
}

// MARK: - Private Methods
extension ActionButton {

	private func applyKerning() {
		let text = titleLabel?.text ?? ""
		titleLabel?.setText(text, withSpacing: characterSpacing)
	}
}
