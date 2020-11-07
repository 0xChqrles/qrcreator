//
//  AttestationViewModel.swift
//  attestation
//
//  Created by Charles Lanier on 02/11/2020.
//

import CoreData

// MARK: - Protocol
protocol AttestationListViewModeling: class {

	var reloadTableView: (() -> ())? { get set }
	var numberOfAttestations: Int { get }

	init(withAPIService: CoreDataAPIService)

	func attestation(atIndexPath: IndexPath) -> Attestation
}

class AttestationListViewModel: NSObject, AttestationListViewModeling {

	// MARK: - Closures
	var reloadTableView: (() -> ())?

	// MARK: - Private Properties
	private let coreDataAPIService: CoreDataAPIService!
	private var attestations = [Attestation]() {
		didSet {
			reloadTableView?()
		}
	}

	// MARK: - Public Properties
	var numberOfAttestations: Int {
		return attestations.count
	}

	// MARK: - Initialization
	required init(withAPIService coreDataAPIService: CoreDataAPIService = CoreDataAPIService()) {
		self.coreDataAPIService = coreDataAPIService
		super.init()

		self.fetchAttestation()
	}
}

// MARK: - Private Methods
extension AttestationListViewModel {

	private func fetchAttestation() {
		coreDataAPIService.fetchEntities(ofType: Attestation.self, withName: "Attestation") { attestations, error in
			if let error = error {
				print(error.localizedDescription)
			} else if let attestations = attestations {
				self.attestations = attestations
			}
		}
	}
}

// MARK: - Public Methods
extension AttestationListViewModel {

	public func attestation(atIndexPath indexPath: IndexPath) -> Attestation {
		return attestations[indexPath.row]
	}
}
