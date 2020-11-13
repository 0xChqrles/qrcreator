//
//  ProfileCellTableViewCell.swift
//   Confined
//
//  Created by Charles Lanier on 02/11/2020.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

	static let identifier = "ProfileCell"

	// MARK: - Public Properties
	private(set) var uuid: String?
	private(set) var isChecked = false {
		didSet {
			if isChecked {
				check()
			} else {
				uncheck()
			}
		}
	}

	// MARK: - Outlets
	@IBOutlet weak var fullNameLabel: UILabel!
	@IBOutlet weak var addressLabel: UILabel!
	@IBOutlet weak var zipCodeCityLabel: UILabel!
	@IBOutlet weak var attestationIcon: UIImageView!
	@IBOutlet weak var checkboxIcon: UIImageView!
	@IBOutlet weak var numberOfAttestationsLabel: UILabel!

	// MARK: - Initialization
	override func awakeFromNib() {
		super.awakeFromNib()

		selectionStyle = .none
	}

	func setProfileData(_ profile: Profile) {
		fullNameLabel.text = "\(profile.firstName) \(profile.lastName)"
		addressLabel.text = profile.address
		zipCodeCityLabel.text = "\(profile.zipCode) \(profile.city)"

		attestationIcon.image = attestationIcon.image?.withRenderingMode(.alwaysTemplate)
		attestationIcon.tintColor = UIColor(named: "AccentColor")
		numberOfAttestationsLabel.text = "\(profile.numberOfAttestations)"
		isChecked = { isChecked }()

		// Profile UUID
		uuid = profile.uuid
	}
}

// MARK: - Private Methods
extension ProfileTableViewCell {

	// Checkbox
	private func uncheck() {
		checkboxIcon.image = UIImage.checkboxEmpty
		checkboxIcon.tintColor = UIColor(named: "Default")
		contentView.backgroundColor = .clear
	}

	private func check() {
		checkboxIcon.image = UIImage.checkboxFilled
		checkboxIcon.tintColor = UIColor(named: "AccentColor")
		contentView.backgroundColor = UIColor(named: "AccentColor")?.withAlphaComponent(0.1)
	}
}

// MARK: - Public Methods
extension ProfileTableViewCell {

	func didSelect() {
		isChecked = !isChecked
	}
}
