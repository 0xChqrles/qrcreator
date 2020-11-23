//
//  UIColor+Utils.swift
//  QR Creator
//
//  Created by Charles Lanier on 22/11/2020.
//

import UIKit

extension UIColor {

	public convenience init?(_ hex: UInt64) {
		let r = CGFloat((hex & 0xff000000) >> 24) / 255
		let g = CGFloat((hex & 0x00ff0000) >> 16) / 255
		let b = CGFloat((hex & 0x0000ff00) >> 8) / 255
		let a = CGFloat(hex & 0x000000ff) / 255

		self.init(red: r, green: g, blue: b, alpha: a)
	}
}
