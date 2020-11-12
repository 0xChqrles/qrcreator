//
//  ReasonsTableViewController.swift
//  attestation
//
//  Created by Charles Lanier on 11/11/2020.
//

import UIKit

class ReasonsViewController: UIViewController {

	// MARK: - Closures
	var onWorkDone: ((Bool) -> ())?

	// MARK: - Private Properties
	// View Models
	private var attestationCreationViewModel: AttestationSetCreationViewModeling
	private lazy var reasonsViewModel: ReasonListViewModeling = {
		return ReasonListViewModel()
	}()

	// MARK: - Outlets
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var navigationBar: UINavigationBar!

	// MARK: - Initialization
	init(attestationCreationViewModel: AttestationSetCreationViewModeling) {
		self.attestationCreationViewModel = attestationCreationViewModel

		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override class func awakeFromNib() {
		super.awakeFromNib()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		// Table View
		tableView.setupCellNib(type: ReasonTableViewCell.self, withIdentifier: ReasonTableViewCell.identifier)

		// View Models
		reasonsViewModel.reloadTableView = tableView.reloadData
		reasonsViewModel.fetchReasons()

		view.backgroundColor = UIColor(named: "Background")
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

		attestationCreationViewModel.clean()
		onWorkDone?(attestationCreationViewModel.isSaved)
	}
}

// MARK: - Table view data source
extension ReasonsViewController: UITableViewDataSource {

	// Rows
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return reasonsViewModel.numberOfReasons
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: ReasonTableViewCell.identifier) as? ReasonTableViewCell else {
			return UITableViewCell()
		}
		let reason = reasonsViewModel.reason(atIndexPath: indexPath)

		cell.setReasonData(reason)
		return cell
	}

	// Sections
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
}

// MARK: - Table view delegate
extension ReasonsViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let cell = tableView.cellForRow(at: indexPath) as? ReasonTableViewCell,
		   let reasonIdentifier = cell.reasonIdentifier {
			attestationCreationViewModel.setReason(withReasonIdentifier: reasonIdentifier)
			attestationCreationViewModel.saveAttestation()
			dismiss(animated: true, completion: nil)
		}
	}
}
