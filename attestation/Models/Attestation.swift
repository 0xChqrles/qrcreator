//
//  Attestation.swift
//  attestation
//
//  Created by Charles Lanier on 02/11/2020.
//

import CoreData

class Attestation: NSManagedObject {

	@NSManaged var id: String
	@NSManaged var reasonsAsIntegers: [Int]

	// MARK: - Getter/Setter
	var reasons: [Reason] {
		get {
			return reasonsAsIntegers.compactMap {
				Reason(rawValue: $0)
			}
		} set {
			reasonsAsIntegers = newValue.map {
				$0.rawValue
			}
		}
	}

	// MARK: - Enum
	enum Reason: Int {
		case work = 248
		case food = 294
		case health = 350
		case family = 391
		case disability = 431
		case sportAndPets = 469
		case convocation = 532
		case missions = 571
		case children = 616

		static let allValues = [work, food, health, family, disability, sportAndPets, convocation, missions, children]
	}
}
