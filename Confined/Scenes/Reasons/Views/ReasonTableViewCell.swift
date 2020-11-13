//
//  ReasonTableViewCell.swift
//   Confined
//
//  Created by Charles Lanier on 11/11/2020.
//

import UIKit

class ReasonTableViewCell: UITableViewCell {

	static let identifier = "ReasonCell"

	// MARK: - Public Properties
	private(set) var reasonIdentifier: String?

	// MARK: - Outlets
	@IBOutlet weak var reasonLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!

	// MARK: - Initialization
	func setReasonData(_ reason: Reason) {
		reasonLabel.text = reason.title
		descriptionLabel.text = reason.description
		reasonIdentifier = reason.identifier
	}
}
