//
//  NSString+Extensions.swift
//  attestation
//
//  Created by Charles Lanier on 01/11/2020.
//

import Foundation
import UIKit

extension NSString {

	func size(withFont font: UIFont) -> CGSize {
		return size(withAttributes: [NSAttributedString.Key.font: font])
	}

	/// return the greater possible font size
	///
	/// - Parameters:
	///     - font: The font to use
	///     - maxWidth: The maximum text width
	///     - minimumFontSize: The minimum font size
	///     - maximumFontSize: The maximum font size
	/// - Returns: the greater font size found and `0` if no font size can respect all parameters
	func getIdealFontSize(withFont font: UIFont, maxWidth: CGFloat, minimumFontSize: CGFloat, maximumFontSize: CGFloat) -> CGFloat {
		var currentSize = maximumFontSize
		var textWidth = self.size(withFont: font.withSize(currentSize)).width

		while textWidth > maxWidth && currentSize > minimumFontSize {
			currentSize -= 1
			textWidth = self.size(withFont: font.withSize(currentSize)).width
		}

		return textWidth > maxWidth ? 0 : currentSize
	}
}
