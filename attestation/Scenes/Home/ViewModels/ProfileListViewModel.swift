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
	var selectionDidBegin: (() -> ())? { get set }
	var selectionDidEnd: (() -> ())? { get set }
	var deleteProfiles: ((Set<String>) -> ())? { get set }

	// MARK: - Public Properties
	var numberOfProfiles: Int { get }

	// MARK: - Initialization
	init(withAPIService: CoreDataAPIService)

	// MARK: - Public Methods
	func fetchProfiles()
	func profile(atIndexPath: IndexPath) -> Profile
	func selectProfile(withUUID: String)
	func unselectProfile(withUUID: String)
	func deleteSelectedProfiles()
}

class ProfileListViewModel: NSObject, ProfileListViewModeling {

	// MARK: - Closures
	var reloadTableView: (() -> ())?
	var selectionDidBegin: (() -> ())?
	var selectionDidEnd: (() -> ())?
	var deleteProfiles: ((Set<String>) -> ())?

	// MARK: - Private Properties
	// CoreData
	private let coreDataAPIService: CoreDataAPIService!
	private let managedObjectContext = CoreDataStorage.shared.managedObjectContext

	private var profiles = [Profile]() {
		didSet {
			if profiles != oldValue {
				reloadTableView?()
			}
		}
	}
	private var selectedProfiles = Set<String>()

	// MARK: - Public Methods
	var numberOfProfiles: Int {
		return profiles.count
	}

	// MARK: - Initialization
	required init(withAPIService coreDataAPIService: CoreDataAPIService = CoreDataAPIService()) {
		self.coreDataAPIService = coreDataAPIService
		super.init()
	}
}

// MARK: - Public Methods
extension ProfileListViewModel {

	// Fetching
	func fetchProfiles() {
		coreDataAPIService.fetchEntities(ofType: Profile.self, withName: "Profile") { profiles, error in
			if let error = error {
				print(error.localizedDescription)
			} else if let profiles = profiles {
				self.profiles = profiles
			}
		}
	}

	// Getter
	func profile(atIndexPath indexPath: IndexPath) -> Profile {
		return profiles[indexPath.row]
	}

	// Selection
	func selectProfile(withUUID uuid: String) {
		if selectedProfiles.count == 0 {
			selectionDidBegin?()
		}
		selectedProfiles.insert(uuid)
	}

	func unselectProfile(withUUID uuid: String) {
		selectedProfiles.remove(uuid)
		if selectedProfiles.count == 0 {
			selectionDidEnd?()
		}
	}

	// Delete
	func deleteSelectedProfiles() {
		if selectedProfiles.isEmpty {
			return
		}

		for profileUUID in selectedProfiles {
			let predicate = NSPredicate(format: "uuid == %@", profileUUID)
			coreDataAPIService.clearStorage(forEntity: "Profile", withPredicate: predicate)
			profiles.removeAll(where: { profile in
				profile.uuid == profileUUID
			})
		}
		deleteProfiles?(selectedProfiles)
		selectedProfiles.removeAll()
		selectionDidEnd?()
	}
}
