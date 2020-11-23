//
//  DateFormatter+Utils.swift
//   Confined
//
//  Created by Charles Lanier on 12/11/2020.
//

import Foundation

extension Date {

	enum Format: String {
		case date = "dd/MM/yyyy"
		case hoursWithDots = "HH:mm"
		case hoursWithLetter = "HH'h'mm"
	}

	func toString(withFormat format: Format) -> String {
		let dateFormatter = DateFormatter()

		dateFormatter.locale = Locale(identifier: "fr_FR")
		dateFormatter.dateFormat = format.rawValue
		return dateFormatter.string(from: self)
	}
}
