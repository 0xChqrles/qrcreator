//
//  AttestationCollectionViewCell.swift
//  attestation
//
//  Created by Charles Lanier on 12/11/2020.
//

import UIKit

class AttestationCollectionViewCell: UICollectionViewCell {

	static let identifier = "AttestationCell"

	// MARK: - Private Properties
	lazy var width: NSLayoutConstraint = {
		let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)

		width.isActive = true
		return width
	}()

	// MARK: - Outlets
	@IBOutlet weak var fullNameLabel: UILabel!
	@IBOutlet weak var qrCodeImageView: UIImageView!

	override func awakeFromNib() {
		super.awakeFromNib()

		// Shape
		layer.cornerRadius = 8

		// Layout
		translatesAutoresizingMaskIntoConstraints = false
	}

	// MARK: - Initialization
	func setAttestationData(_ attestation: Attestation) {
		fullNameLabel.text = attestation.fullName
		qrCodeImageView.image = attestation.qrCode
	}

	override func systemLayoutSizeFitting(
		_ targetSize: CGSize,
		withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
		verticalFittingPriority: UILayoutPriority
	) -> CGSize {
		width.constant = bounds.size.width
		return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
	}
}
