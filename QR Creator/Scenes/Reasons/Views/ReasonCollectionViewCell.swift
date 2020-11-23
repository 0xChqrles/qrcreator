//
//  ReasonTableViewCell.swift
//   Confined
//
//  Created by Charles Lanier on 11/11/2020.
//

import UIKit

class ReasonCollectionViewCell: UICollectionViewCell {

	static let identifier = "ReasonCell"

	// MARK: - Private Properties
	private var defaultBackgroundColor: UIColor?

	// MARK: - Public Properties
	private(set) var reasonIdentifier: String?

	// MARK: - Outlets
	@IBOutlet weak var reasonIcon: UIImageView!

	// MARK: - Initialization
	override func awakeFromNib() {
		super.awakeFromNib()

		// Shape
		layer.cornerRadius = 8

		// Style
		defaultBackgroundColor = contentView.backgroundColor
	}

	func setReasonData(_ reason: Reason) {
		reasonIcon.image = reason.icon
		reasonIcon.tintColor = reason.color
		reasonIdentifier = reason.identifier
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if #available(iOS 13.0, *) {
			contentView.backgroundColor = .tertiarySystemGroupedBackground
		}

		super.touchesBegan(touches, with: event)
	}

	override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesCancelled(touches, with: event)

		contentView.backgroundColor = defaultBackgroundColor
	}
}
