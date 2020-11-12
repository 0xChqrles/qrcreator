//
//  AttestationProfile.swift
//  attestation
//
//  Created by Charles Lanier on 01/11/2020.
//

import CoreData

class Profile: NSManagedObject {

	@nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
		return NSFetchRequest<Profile>(entityName: "Profile")
	}

	@NSManaged public var address: String
	@NSManaged public var birthCity: String
	@NSManaged public var birthDate: String
	@NSManaged public var city: String
	@NSManaged public var firstName: String
	@NSManaged public var lastName: String
	@NSManaged public var numberOfAttestations: Int64
	@NSManaged public var uuid: String
	@NSManaged public var zipCode: String

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
