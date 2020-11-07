//
//  ProfileCreationViewModel.swift
//  attestation
//
//  Created by Charles Lanier on 05/11/2020.
//

import CoreData

protocol ProfileCreationViewModeling: class {

	// MARK: - Closures
	var updateProfileStatus: ((Bool) -> ())? { get set }

	// MARK: - Initialization
	init(withAPIService: CoreDataAPIService)

	// MARK: - Public Methods
	func value(forKey key: String) -> String?
	func updateProfile(forKey: String, withValue: String)
	func saveProfile()
}

class ProfileCreationViewModel: ProfileCreationViewModeling {

	// MARK: - Closures
	var updateProfileStatus: ((Bool) -> ())?

	// MARK: - Private Properties
	private let coreDataAPIService: CoreDataAPIService!
	private lazy var profile: Profile? = {
		let managedObjectContext = CoreDataStorage.shared.managedObjectContext
		if let entityDescription = NSEntityDescription.entity(forEntityName: "Profile", in: managedObjectContext) {
			return Profile(entity: entityDescription, insertInto: managedObjectContext)
		}
		return nil
	}()
	private var isProfileFulfilled = false {
		didSet {
			if isProfileFulfilled != oldValue {
				updateProfileStatus?(isProfileFulfilled)
			}
		}
	}

	required init(withAPIService coreDataAPIService: CoreDataAPIService) {
		self.coreDataAPIService = coreDataAPIService
	}
}

// MARK: - Public Methods
extension ProfileCreationViewModel {

	func value(forKey key: String) -> String? {
		return profile?.value(forKey: key) as? String
	}

	func updateProfile(forKey key: String, withValue value: String) {
		guard let profile = profile else {
			return
		}

		profile.setValue(value, forKey: key)
		isProfileFulfilled = profile.isFulfilled
	}

	func saveProfile() {
		let managedObjectContext = CoreDataStorage.shared.managedObjectContext

		do {
			try managedObjectContext.save()
		} catch {
			print(error.localizedDescription)
		}
	}
}
