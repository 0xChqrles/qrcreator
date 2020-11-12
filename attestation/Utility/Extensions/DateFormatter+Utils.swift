//
//  DateFormatter+Utils.swift
//  attestation
//
//  Created by Charles Lanier on 12/11/2020.
//

import Foundation

extension Date {

	enum Format: String {
		case date = "dd/MM/yyyy"
		case hoursWithDots = "hh:mm"
		case hoursWithLetter = "hh'h'mm"
	}

	func toString(withFormat format: Format) -> String {
		let dateFormatter = DateFormatter()

		dateFormatter.dateFormat = format.rawValue
		return dateFormatter.string(from: self)
	}
}
