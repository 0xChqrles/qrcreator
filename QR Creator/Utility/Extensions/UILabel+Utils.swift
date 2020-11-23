//
//  UILabel+Utils.swift
//   Confined
//
//  Created by Charles Lanier on 08/11/2020.
//

import UIKit

extension UILabel {

	func setText(_ text: String, withSpacing spacing: CGFloat) {
		attributedText = NSAttributedString(string: text, attributes: [.kern: spacing])
	}
}
