//
//  Reason.swift
//   Confined
//
//  Created by Charles Lanier on 11/11/2020.
//

import Foundation

// MARK: - Enum
class Reason {

	// MARK: - Properties
	var title: String
	var description: String
	var identifier: String

	// MARK: - Initialization
	init(title: String, description: String, identifier: String) {
		self.title = title
		self.description = description
		self.identifier = identifier
	}
}
