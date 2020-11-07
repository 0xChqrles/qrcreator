//
//  QRCodeViewModel.swift
//  attestation
//
//  Created by Charles Lanier on 01/11/2020.
//

import Foundation
import UIKit

class QRCodeViewModel: NSObject {

	func getQRCode(fromString string: String) -> UIImage? {
		let data = string.data(using: .ascii)

		if let filter = CIFilter(name: "CIQRCodeGenerator") {
			filter.setValue(data, forKey: "inputMessage")
			filter.setValue("M", forKey: "inputCorrectionLevel")
			let transform = CGAffineTransform(scaleX: 2, y: 2)

			if let output = filter.outputImage?.transformed(by: transform) {
				let qrCode = UIImage(ciImage: output)

				return qrCode
			}
		}
		return nil
	}
}
