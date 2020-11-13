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
	// View Models
	var attestationGenerationViewModel: AttestationSetCreationViewModeling { get }

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

	private var profiles = [Profile]()
	private var selectedProfilesUUID = Set<String>()
	private var selectedProfiles: [Profile] {
		return self.profiles.filter {
			selectedProfilesUUID.contains($0.uuid)
		}
	}

	// MARK: - Public Properties
	// View Models
	var attestationGenerationViewModel: AttestationSetCreationViewModeling {
		let viewModel = AttestationSetCreationViewModel()
		viewModel.setProfiles(selectedProfiles)
		return viewModel
	}

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
		if let profiles = coreDataAPIService.fetchEntities(ofType: Profile.self, withName: "Profile") {
			self.profiles = profiles
			self.reloadTableView?()
		}
	}

	// Getter
	func profile(atIndexPath indexPath: IndexPath) -> Profile {
		return profiles[indexPath.row]
	}

	// Selection
	func selectProfile(withUUID uuid: String) {
		if selectedProfilesUUID.count == 0 {
			selectionDidBegin?()
		}
		selectedProfilesUUID.insert(uuid)
	}

	func unselectProfile(withUUID uuid: String) {
		selectedProfilesUUID.remove(uuid)
		if selectedProfilesUUID.count == 0 {
			selectionDidEnd?()
		}
	}

	// Delete
	func deleteSelectedProfiles() {
		if selectedProfilesUUID.isEmpty {
			return
		}

		for profileUUID in selectedProfilesUUID {
			let predicate = NSPredicate(format: "uuid == %@", profileUUID)
			coreDataAPIService.clearStorage(forEntity: "Profile", withPredicate: predicate)
			profiles.removeAll(where: { profile in
				profile.uuid == profileUUID
			})
		}
		deleteProfiles?(selectedProfilesUUID)
		if profiles.isEmpty {
			reloadTableView?()
		}
		selectedProfilesUUID.removeAll()
		selectionDidEnd?()
	}
}
