//
//  Attestation.swift
//  attestation
//
//  Created by Charles Lanier on 12/11/2020.
//

import UIKit.UIImage

class Attestation {

	// MARK: - Public Properties
	var qrCode: UIImage
	var fullName: String

	// MARK: - Initialization
	init(qrCode: UIImage, fullName: String) {
		self.qrCode = qrCode
		self.fullName = fullName
	}
}
