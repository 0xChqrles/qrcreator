//
//  QRCodeViewModel.swift
//   Confined
//
//  Created by Charles Lanier on 01/11/2020.
//

import Foundation
import UIKit

protocol QRCodeAPIServicable {

	// MARK: - Public Methods
	func getQRCode(fromString: String) -> UIImage?
}

class QRCodeAPIService: NSObject, QRCodeAPIServicable {

	// Singleton
	static var shared = QRCodeAPIService()

	// MARK: - Public Methods
	func getQRCode(fromString string: String) -> UIImage? {
		
		let data = string.data(using: .ascii)
		if let filter = CIFilter(name: "CIQRCodeGenerator") {
			filter.setValue(data, forKey: "inputMessage")
			filter.setValue("M", forKey: "inputCorrectionLevel")
			let transform = CGAffineTransform(scaleX: 5, y: 5)

			if let output = filter.outputImage?.transformed(by: transform) {
				let qrCode = UIImage(ciImage: output)

				return qrCode
			}
		}
		return nil
	}
}
