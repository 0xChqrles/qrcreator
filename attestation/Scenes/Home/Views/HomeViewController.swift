//
//  ProfileTableViewController.swift
//  attestation
//
//  Created by Charles Lanier on 02/11/2020.
//

import UIKit

class HomeViewController: UIViewController {

	// MARK: - Private Properties
	private let rowsHeight = CGFloat(44)
	// View Models
	private var profileListViewModel: ProfileListViewModeling!

	// MARK: - Outlets
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var outingButton: UIButton!
	@IBOutlet var trashButtonItem: UIBarButtonItem!

	// Constraints
	@IBOutlet weak var outingButtonBottomConstraint: NSLayoutConstraint!

	// MARK: - Actions
	@objc
	func addProfile() {
		let profileCreationViewModel = ProfileCreationViewModel(withAPIService: CoreDataStorage.shared.apiService)
		let profileEditorViewController = ProfileEditorViewController(profileCreationViewModel: profileCreationViewModel)

		navigationController?.pushViewController(profileEditorViewController, animated: true)
	}

	@objc
	func removeProfiles() {
		profileListViewModel.deleteSelectedProfiles()
	}

	// MARK: - Initialization
	init(profileListViewModel: ProfileListViewModeling) {
		// View Models
		self.profileListViewModel = profileListViewModel

		super.init(nibName: nil, bundle: nil)

		// Navigation
		trashButtonItem = UIBarButtonItem(
			barButtonSystemItem: .trash,
			target: self,
			action: #selector(removeProfiles)
		)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		// Outing Button
		profileListViewModel.selectionDidBegin = selectFirstProfile
		profileListViewModel.selectionDidEnd = unselectLastProfile
		profileListViewModel.deleteProfiles = deleteSelectedCells
		outingButton.layer.cornerRadius = 8
		outingButton.titleLabel?.setText("SORTIR", withSpacing: 2.0)
		hideTrashAndOutingButton(false)

		// Table View
		tableView.delegate = self
		tableView.dataSource = self
		tableView.setupCellNib(type: ProfileTableViewCell.self, withIdentifier: ProfileTableViewCell.identifier)
		tableView.setupCellNib(type: SectionTitleCell.self, withIdentifier: SectionTitleCell.identifier)

		// Profile List View Model
		profileListViewModel.reloadTableView = reloadTableView
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		// Fetch profiles
		profileListViewModel.fetchProfiles()

		// Navigation
		// Add
		let addButtonItem = UIBarButtonItem(
			barButtonSystemItem: .add,
			target: self,
			action: #selector(addProfile)
		)
		addButtonItem.tintColor = UIColor(named: "AccentColor")
		navigationController?.navigationBar.topItem?.rightBarButtonItem = addButtonItem

		// Title
		navigationItem.title = "CONFINED"
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationController?.navigationBar.topItem?.largeTitleDisplayMode = .automatic
		navigationController?.navigationBar.sizeToFit()
		navigationController?.navigationBar.isTranslucent = true

		// Trash
		navigationController?.navigationBar.topItem?.leftBarButtonItem = trashButtonItem
	}
}

// MARK: - Private Methods
extension HomeViewController {

	private func reloadTableView() {
		tableView.reloadData()
	}

	private func deleteSelectedCells(withUUIDS uuids: Set<String>) {
		var indexPaths = [IndexPath]()
		for section in 0 ..< tableView.numberOfSections {
			for row in 0 ..< tableView.numberOfRows(inSection: section) {
				let indexPath = IndexPath(row: row, section: section)

				if let cell = tableView.cellForRow(at: indexPath) as? ProfileTableViewCell,
				   cell.isChecked {
					cell.didSelect()
					indexPaths.append(indexPath)
				}
			}
		}

		tableView.deleteRows(at: indexPaths, with: .fade)
	}

	private func selectFirstProfile() {
		showTrashAndOutingButton(true)
	}

	private func unselectLastProfile() {
		hideTrashAndOutingButton(true)
	}

	private func hideTrashAndOutingButton(_ animated: Bool) {
		// Outing Button
		if #available(iOS 11.0, *),
		   let window = UIApplication.shared.keyWindow {
			outingButtonBottomConstraint.constant = -window.safeAreaInsets.bottom
		} else {
			outingButtonBottomConstraint.constant = 0
		}

		UIView.animate(withDuration: animated ? 0.3 : 0) {
			self.view.layoutIfNeeded()
			self.outingButton.alpha = 0
		}

		// Trash Item
		trashButtonItem.isEnabled = false
		trashButtonItem.tintColor = .clear
	}

	private func showTrashAndOutingButton(_ animated: Bool) {
		// Outing Button
		outingButtonBottomConstraint.constant = 8

		UIView.animate(withDuration: animated ? 0.3 : 0) {
			self.view.layoutIfNeeded()
			self.outingButton.alpha = 1
		}

		// Trash Item
		trashButtonItem.isEnabled = true
		trashButtonItem.tintColor = UIColor(named: "AccentColor")
	}
}

// MARK: - TableView DataSource
extension HomeViewController: UITableViewDataSource {

	// Rows
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return profileListViewModel.numberOfProfiles
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
				withIdentifier: ProfileTableViewCell.identifier
		) as? ProfileTableViewCell else {
			return UITableViewCell()
		}

		cell.setProfileData(profileListViewModel.profile(atIndexPath: indexPath))
		return cell
	}

	// Sections
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		if let cell = tableView.dequeueReusableCell(withIdentifier: SectionTitleCell.identifier) as? SectionTitleCell {
			cell.setSectionData(title: "PROFILS")
			return cell
		}
		return UIView()
	}

	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		return UIView()
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return rowsHeight
	}

	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return rowsHeight * 2
	}
}

// MARK: - TableView Delegate
extension HomeViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let cell = tableView.cellForRow(at: indexPath) as? ProfileTableViewCell,
		   let profileUUID = cell.uuid {
			cell.didSelect()
			if cell.isChecked {
				profileListViewModel.selectProfile(withUUID: profileUUID)
			} else {
				profileListViewModel.unselectProfile(withUUID: profileUUID)
			}
		}
	}
}
