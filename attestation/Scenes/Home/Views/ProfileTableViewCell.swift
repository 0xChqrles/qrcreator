//
//  ProfileCellTableViewCell.swift
//  attestation
//
//  Created by Charles Lanier on 02/11/2020.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

	static let identifier = "ProfileCell"

	// MARK: - Outlets
	@IBOutlet weak var fullNameLabel: UILabel!

	// MARK: - Public Properties
	public func setProfileData(_ profile: Profile) {
		fullNameLabel?.text = "\(profile.firstName) \(profile.lastName)"
	}
}
