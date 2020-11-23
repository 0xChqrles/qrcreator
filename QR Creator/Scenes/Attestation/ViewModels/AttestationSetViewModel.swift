//
//  AttestationViewModel.swift
//   Confined
//
//  Created by Charles Lanier on 10/11/2020.
//

import UIKit.UIImage

protocol AttestationSetViewModeling {

	// MARK: - Closures
	var reloadCollectionView: (() -> ())? { get set }

	// MARK:
	var numberOfAttestations: Int { get }

	// MARK: - Public Methods
	func fetchLastAttestationSet()
	func attestation(atIndexPath: IndexPath) -> Attestation
	func dismiss()
}

class AttestationSetViewModel: NSObject, AttestationSetViewModeling {

	// MARK: - Closures
	var reloadCollectionView: (() -> ())?

	// MARK: - Private Properties
	// CoreData
	private let coreDataAPIService: CoreDataAPIService!
	private let managedObjectContext = CoreDataStorage.shared.managedObjectContext

	private var qrCodeAPIService: QRCodeAPIServicable?
	private var attestations = [Attestation]()

	// MARK: - Public Properties
	var numberOfAttestations: Int {
		return attestations.count
	}

	// MARK: - Initialization
	init(qrCodeAPIService: QRCodeAPIServicable) {
		coreDataAPIService = CoreDataStorage.shared.apiService
		self.qrCodeAPIService = qrCodeAPIService
	}
}

// MARK: - Private Methods
extension AttestationSetViewModel {

	private func setAttestations(fromAttestationSet attestationSet: AttestationSet) {
		guard let profiles = attestationSet.profiles?.array as? [Profile],
			  let creationDate = attestationSet.creationDate,
			  let reasonIdentifier = attestationSet.reasonIdentifier else {
			return
		}

		for profile in profiles {
			let fullName = "\(profile.firstName) \(profile.lastName)"
			let qrCodeData = """
			Cree le: \(creationDate.toString(withFormat: .date)) a \(creationDate.toString(withFormat: .hoursWithLetter));
			Nom: \(profile.lastName);
			Prenom: \(profile.firstName);
			Naissance: \(profile.birthDate) a \(profile.birthCity);
			Adresse: \(profile.address);
			Sortie: \(creationDate.toString(withFormat: .date)) a \(creationDate.toString(withFormat: .hoursWithDots));
			Motifs: \(reasonIdentifier);
			"""

			if let qrCode = qrCodeAPIService?.getQRCode(fromString: qrCodeData) {
				attestations.append(Attestation(qrCode: qrCode, fullName: fullName))
			}
		}
	}
}

// MARK: - Public Methods
extension AttestationSetViewModel {

	func fetchLastAttestationSet() {
		let sort = NSSortDescriptor(key: "creationDate", ascending: false)
		guard let attestationSets = coreDataAPIService.fetchEntities(
			ofType: AttestationSet.self,
			withName: "AttestationSet",
			sortedBy: [sort]
		), attestationSets.count > 0 else {
			return
		}
		setAttestations(fromAttestationSet: attestationSets[0])
		reloadCollectionView?()
	}

	func attestation(atIndexPath indexPath: IndexPath) -> Attestation {
		return attestations[indexPath.row]
	}

	func dismiss() {
		UserDefaults.standard.setValue(false, forKey: UserDefaults.Attestation.isAttestationActiveKey)
	}
}
