//
//  AttestationProfile.swift
//  attestation
//
//  Created by Charles Lanier on 01/11/2020.
//

import CoreData

class Profile: NSManagedObject {
	@NSManaged var uuid: String
	@NSManaged var firstName: String
	@NSManaged var lastName: String
	@NSManaged var birthDate: String
	@NSManaged var birthCity: String
	@NSManaged var address: String
	@NSManaged var city: String
	@NSManaged var zipCode: String
	@NSManaged var numberOfAttestations: Int

	var isFulfilled: Bool {
		return !(firstName.isEmpty
			|| lastName.isEmpty
			|| birthDate.isEmpty
			|| birthCity.isEmpty
			|| address.isEmpty
			|| city.isEmpty
			|| zipCode.isEmpty)
	}

	override func awakeFromInsert() {
		super.awakeFromInsert()
		setPrimitiveValue(0, forKey: "numberOfAttestations")
		setPrimitiveValue(UUID().uuidString, forKey: "uuid")
	}
}
