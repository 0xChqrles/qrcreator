//
//  SectionTitleCell.swift
//  attestation
//
//  Created by Charles Lanier on 05/11/2020.
//

import UIKit

class SectionTitleCell: UITableViewCell {

	static let identifier = "SectionTitleCell"

	// MARK: - Outlets
	@IBOutlet weak var titleLabel: UILabel!

	func setSectionData(title: String) {
		titleLabel.text = title
	}
}
