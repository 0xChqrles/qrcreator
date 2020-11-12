//
//  AttestationGenerationViewModel.swift
//  attestation
//
//  Created by Charles Lanier on 11/11/2020.
//

import CoreData

protocol AttestationSetCreationViewModeling {

	// MARK: - Public Properties
	var isSaved: Bool { get }

	// MARK: - Public Methods
	func setReason(withReasonIdentifier: String)
	func setProfiles(_: [Profile])
	func saveAttestation()
	func clean()
}

class AttestationSetCreationViewModel: AttestationSetCreationViewModeling {

	// MARK: - Private Properties
	// CoreData
	private let managedObjectContext = CoreDataStorage.shared.managedObjectContext

	private lazy var attestation: AttestationSet? = {
		if let entityDescription = NSEntityDescription.entity(forEntityName: "AttestationSet", in: managedObjectContext) {
			return AttestationSet(entity: entityDescription, insertInto: managedObjectContext)
		}
		return nil
	}()

	// MARK: - Public Properties
	private(set) var isSaved = false

	// MARK: - Deinit
	deinit {
		managedObjectContext.rollback()
	}
}

// MARK: - Private Methods
extension AttestationSetCreationViewModel {

	private func cleanAttesations() {
		CoreDataStorage.shared.apiService.clearStorage(forEntity: "AttestationSet")
	}

	private func increaseAttestationProfilesCount() {
		guard let profiles = attestation?.profiles else {
			return
		}

		for case let profile as Profile in profiles {
			profile.numberOfAttestations += 1
		}
	}
}

// MARK: - Public Methods
extension AttestationSetCreationViewModel {

	func setReason(withReasonIdentifier reasonIdentifier: String) {
		self.attestation?.reasonIdentifier = reasonIdentifier
		isSaved = false
	}

	func setProfiles(_ profiles: [Profile]) {
		self.attestation?.addToProfiles(NSOrderedSet(array: profiles))
		isSaved = false
	}

	func saveAttestation() {
		if attestation?.profiles?.count ?? 0 > 0 {
			do {
				increaseAttestationProfilesCount()
				attestation?.creationDate = Date()
				try managedObjectContext.save()
				isSaved = true
				UserDefaults.standard.setValue(true, forKey: UserDefaults.Attestation.isAttestationActiveKey)
			} catch {
				print(error.localizedDescription)
			}
		}
	}

	func clean() {
		managedObjectContext.rollback()
	}
}
