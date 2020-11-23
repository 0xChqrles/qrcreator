//
//  ProfileCreationViewModel.swift
//   Confined
//
//  Created by Charles Lanier on 05/11/2020.
//

import CoreData

protocol ProfileCreationViewModeling: class {

	// MARK: - Closures
	var updateProfileStatus: ((Bool) -> ())? { get set }

	// MARK: - Public Methods
	func value(forKey key: String) -> String?
	func updateProfile(forKey: String, withValue: String)
	func saveProfile()
	func clean()
}

class ProfileCreationViewModel: ProfileCreationViewModeling {

	// MARK: - Closures
	var updateProfileStatus: ((Bool) -> ())?

	// MARK: - Private Properties
	// CoreData
	private let managedObjectContext = CoreDataStorage.shared.managedObjectContext

	private lazy var profile: Profile? = {
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

		let trimmedValue = value.trimmingCharacters(in: .whitespacesAndNewlines)

		profile.setValue(trimmedValue, forKey: key)
		isProfileFulfilled = profile.isFulfilled
	}

	func saveProfile() {
		if !(profile?.isFulfilled ?? false) {
			return
		}

		profile?.firstName.capitalizeFirstLetter()
		profile?.lastName.capitalizeFirstLetter()
		profile?.city.capitalizeFirstLetter()
		profile?.birthCity.capitalizeFirstLetter()
		do {
			try managedObjectContext.save()
		} catch {
			print(error.localizedDescription)
		}
	}

	func clean() {
		managedObjectContext.rollback()
	}
}
