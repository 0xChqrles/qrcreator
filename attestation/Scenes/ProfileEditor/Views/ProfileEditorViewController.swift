//
//  ProfileEditorViewController.swift
//  attestation
//
//  Created by Charles Lanier on 02/11/2020.
//

import UIKit

class ProfileEditorViewController: UITableViewController {

	// MARK: - Private Properties
	private let rowsHeight = CGFloat(44)
	// View Models
	private lazy var formViewModel: FormViewModel = {
		return FormViewModel()
	}()
	private var profileCreationViewModel: ProfileCreationViewModeling

	// MARK: - Actions
	@objc
	func addProfile() {
		profileCreationViewModel.saveProfile()
		navigationController?.popViewController(animated: true)
	}

	// MARK: - Initialization
	init(profileCreationViewModel: ProfileCreationViewModeling) {
		self.profileCreationViewModel = profileCreationViewModel
		super.init(style: .grouped)

		self.profileCreationViewModel.updateProfileStatus = { [weak self] isProfileValid in
			self?.updateProfileStatus(isProfileValid)
		}
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		// setup cells nib
		tableView.setupCellNib(type: TextFieldCell.self, withIdentifier: TextFieldCell.identifier)
		tableView.setupCellNib(type: DatePickerCell.self, withIdentifier: DatePickerCell.identifier)
		tableView.setupCellNib(type: SectionTitleCell.self, withIdentifier: SectionTitleCell.identifier)

		navigationItem.title = "Ajouter un profil"

		// setup tableView
		if #available(iOS 13.0, *) {
			tableView.backgroundColor = .systemGroupedBackground
		} else {
			tableView.backgroundColor = .lightGray
		}
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		let addButton = UIBarButtonItem(
			title: "Ajouter",
			style: .plain,
			target: self,
			action: #selector(addProfile)
		)
		addButton.isEnabled = false
		navigationItem.rightBarButtonItem = addButton

		navigationController?.navigationBar.topItem?.backButtonTitle = "Annuler"
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		profileCreationViewModel.clean()
	}
}

// MARK: - Private Methods
extension ProfileEditorViewController {

	private func updateProfileStatus(_ isProfileValid: Bool) {
		navigationItem.rightBarButtonItem?.isEnabled = isProfileValid
	}

	private func cellDidUpdate(forKey key: String, withValue value: String) {
		profileCreationViewModel.updateProfile(forKey: key, withValue: value)
	}
}

// MARK: - TableView DataSource
extension ProfileEditorViewController {

	// Rows
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let row = formViewModel.form.sections[indexPath.section].rows[indexPath.row]
		let cell: InputCellable?

		switch row.input {
		case let .text(placeholder, dataType):
			cell = tableView.dequeueReusableCell(withIdentifier: TextFieldCell.identifier) as? InputCellable
			(cell as? TextFieldCell)?.setTextFieldData(placeholder: placeholder, dataType: dataType)

		case let .date(title):
			cell = tableView.dequeueReusableCell(withIdentifier: DatePickerCell.identifier) as? InputCellable
			(cell as? DatePickerCell)?.setDatePickerData(title: title)
		}

		if let cell = cell {
			let value = profileCreationViewModel.value(forKey: row.key)
			cell.configure(key: row.key, defaultValue: value) { [weak self] key, value in
				self?.cellDidUpdate(forKey: key, withValue: value)
			}
			return cell
		}
		return UITableViewCell()
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return formViewModel.numberOfRows(inSection: section)
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return rowsHeight
	}

	// Sections
	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		if let cell = tableView.dequeueReusableCell(withIdentifier: SectionTitleCell.identifier) as? SectionTitleCell,
		   let title = formViewModel.form.sections[section].title {
			cell.setSectionData(title: title)
			return cell
		}
		return UIView()
	}

	override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		return UIView()
	}

	override func numberOfSections(in tableView: UITableView) -> Int {
		return formViewModel.numberOfSections()
	}

	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return rowsHeight
	}

	override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return rowsHeight / 2
	}
}

// MARK: - TableView Delegate
extension ProfileEditorViewController {

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let cell = tableView.cellForRow(at: indexPath) as? DatePickerCell {
			if cell.isFirstResponder {
				cell.resignFirstResponder()
			} else {
				cell.becomeFirstResponder()
			}
		}
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
