//
//  String+Utils.swift
//  attestation
//
//  Created by Charles Lanier on 08/11/2020.
//

import Foundation

extension String {
	func capitalizingFirstLetter() -> String {
		return prefix(1).capitalized + dropFirst()
	}

	mutating func capitalizeFirstLetter() {
		self = capitalizingFirstLetter()
	}
}
