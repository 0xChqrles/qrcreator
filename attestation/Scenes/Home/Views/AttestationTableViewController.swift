//
//  ViewController.swift
//  attestation
//
//  Created by Charles Lanier on 01/11/2020.
//

import UIKit

class AttestationTableViewController: UITableViewController {

	// MARK: - Private Properties
	// View Models
	private var attestationListViewModel: AttestationListViewModeling!

	// MARK: - Initialization
	init(attestationListViewModel: AttestationListViewModeling) {
		self.attestationListViewModel = attestationListViewModel
		super.init(nibName: nil, bundle: nil)

		self.attestationListViewModel.reloadTableView = tableView.reloadData
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()

		setupCellNib(type: AttestationTableViewCell.self, withIdentifier: AttestationTableViewCell.identifier)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		navigationController?.navigationBar.topItem?.title = "Attestations"
	}
}

// MARK: - TableView DataSource
extension AttestationTableViewController {

	// Rows
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return attestationListViewModel.numberOfAttestations
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
				withIdentifier: AttestationTableViewCell.identifier
		) as? AttestationTableViewCell else {
			return UITableViewCell()
		}

		cell.setAttestationData(attestationListViewModel.attestation(atIndexPath: indexPath))
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
extension AttestationTableViewController {

//	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//	}
}
