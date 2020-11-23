//
//  Reason.swift
//   Confined
//
//  Created by Charles Lanier on 11/11/2020.
//

import Foundation
import UIKit.UIImage
import UIKit.UIColor

// MARK: - Enum
class Reason {

	// MARK: - Properties
	var icon: UIImage?
	var color: UIColor?
	var identifier: String

	// MARK: - Initialization
	init(icon: UIImage?, color: UIColor?, identifier: String) {
		self.icon = icon
		self.color = color
		self.identifier = identifier
	}
}
