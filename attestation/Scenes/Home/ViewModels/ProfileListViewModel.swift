//
//  AttestationViewModel.swift
//  attestation
//
//  Created by Charles Lanier on 01/11/2020.
//

import CoreData

// MARK: - Protocol
protocol ProfileListViewModeling: class {

	// MARK: - Closures
	var reloadTableView: (() -> ())? { get set }

	// MARK: - Public Properties
	var numberOfProfiles: Int { get }

	// MARK: - Initialization
	init(withAPIService: CoreDataAPIService)

	// MARK: - Public Methods
	func fetchProfiles()
	func profile(atIndexPath: IndexPath) -> Profile
}

class ProfileListViewModel: NSObject, ProfileListViewModeling {

	// MARK: - Closures
	var reloadTableView: (() -> ())?

	// MARK: - Private Properties
	private let coreDataAPIService: CoreDataAPIService!
	private var profiles = [Profile]() {
		didSet {
			if profiles != oldValue {
				reloadTableView?()
			}
		}
	}

	// MARK: - Initialization
	required init(withAPIService coreDataAPIService: CoreDataAPIService = CoreDataAPIService()) {
		self.coreDataAPIService = coreDataAPIService
		super.init()
	}
}

// MARK: - Public Methods
extension ProfileListViewModel {

	func fetchProfiles() {
		coreDataAPIService.fetchEntities(ofType: Profile.self, withName: "Profile") { profiles, error in
			if let error = error {
				print(error.localizedDescription)
			} else if let profiles = profiles {
				self.profiles = profiles
			}
		}
	}

	var numberOfProfiles: Int {
		return profiles.count
	}

	public func profile(atIndexPath indexPath: IndexPath) -> Profile {
		return profiles[indexPath.row]
	}
}
