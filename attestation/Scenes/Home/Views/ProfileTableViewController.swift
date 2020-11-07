//
//  ProfileTableViewController.swift
//  attestation
//
//  Created by Charles Lanier on 02/11/2020.
//

import UIKit

class ProfileTableViewController: UITableViewController {

	// MARK: - Private Properties
	// View Models
	private var profileListViewModel: ProfileListViewModeling!

	// MARK: - Initialization
	init(profileListViewModel: ProfileListViewModeling) {
		self.profileListViewModel = profileListViewModel
		super.init(nibName: nil, bundle: nil)

		self.profileListViewModel.reloadTableView = tableView.reloadData
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		setupCellNib(type: ProfileTableViewCell.self, withIdentifier: ProfileTableViewCell.identifier)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		// Fetch profiles
		profileListViewModel.fetchProfiles()

		// Add button
		let barButtonItem = UIBarButtonItem(
			barButtonSystemItem: .add,
			target: self,
			action: #selector(addProfile)
		)
		barButtonItem.tintColor = UIColor(named: "AccentColor")
		navigationController?.navigationBar.topItem?.rightBarButtonItem = barButtonItem
		navigationController?.navigationBar.topItem?.title = "Profils"
	}

	// MARK: - Actions
	@objc
	func addProfile() {
		let profileCreationViewModel = ProfileCreationViewModel(withAPIService: CoreDataStorage.shared.apiService)
		let profileEditorViewController = ProfileEditorViewController(profileCreationViewModel: profileCreationViewModel)

		navigationController?.pushViewController(profileEditorViewController, animated: true)
	}
}

// MARK: - TableView DataSource
extension ProfileTableViewController {

	// Rows
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return profileListViewModel.numberOfProfiles
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
				withIdentifier: ProfileTableViewCell.identifier
		) as? ProfileTableViewCell else {
			return UITableViewCell()
		}

		cell.setProfileData(profileListViewModel.profile(atIndexPath: indexPath))
		return cell
	}

	// Sections
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		return UIView()
	}
}

// MARK: - TableView Delegate
extension ProfileTableViewController {

//	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		performSegue(withIdentifier: "profile", sender: profileViewMode.profiles[indexPath.row])
//	}
}
