//
//  String+Utils.swift
//   Confined
//
//  Created by Charles Lanier on 08/11/2020.
//

import Foundation

extension String {

	var ascii: String? {
		let str = self.folding(options: .diacriticInsensitive, locale: .current)
		do {
			let regex = try NSRegularExpression(pattern: "[^\\x00-\\x7F]", options: NSRegularExpression.Options.caseInsensitive)
			return regex.stringByReplacingMatches(in: str, options: [], range: NSRange(0..<str.utf16.count), withTemplate: "")
		} catch {
			print(error.localizedDescription)
			return nil
		}
	}

	func capitalizingFirstLetter() -> String {
		return prefix(1).capitalized + dropFirst()
	}

	mutating func capitalizeFirstLetter() {
		self = capitalizingFirstLetter()
	}
}
