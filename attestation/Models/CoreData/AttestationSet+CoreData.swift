//
//  Attestation+CoreDataProperties.swift
//  attestation
//
//  Created by Charles Lanier on 10/11/2020.
//
//

import Foundation
import CoreData

class AttestationSet: NSManagedObject {

	@nonobjc public class func fetchRequest() -> NSFetchRequest<AttestationSet> {
		return NSFetchRequest<AttestationSet>(entityName: "Attestation")
	}

	@NSManaged public var reasonIdentifier: String?
	@NSManaged public var creationDate: Date?
	@NSManaged public var profiles: NSOrderedSet?
}

// MARK: Generated accessors for profiles
extension AttestationSet {

	@objc(insertObject:inProfilesAtIndex:)
	@NSManaged public func insertIntoProfiles(_ value: Profile, at idx: Int)

	@objc(removeObjectFromProfilesAtIndex:)
	@NSManaged public func removeFromProfiles(at idx: Int)

	@objc(insertProfiles:atIndexes:)
	@NSManaged public func insertIntoProfiles(_ values: [Profile], at indexes: NSIndexSet)

	@objc(removeProfilesAtIndexes:)
	@NSManaged public func removeFromProfiles(at indexes: NSIndexSet)

	@objc(replaceObjectInProfilesAtIndex:withObject:)
	@NSManaged public func replaceProfiles(at idx: Int, with value: Profile)

	@objc(replaceProfilesAtIndexes:withProfiles:)
	@NSManaged public func replaceProfiles(at indexes: NSIndexSet, with values: [Profile])

	@objc(addProfilesObject:)
	@NSManaged public func addToProfiles(_ value: Profile)

	@objc(removeProfilesObject:)
	@NSManaged public func removeFromProfiles(_ value: Profile)

	@objc(addProfiles:)
	@NSManaged public func addToProfiles(_ values: NSOrderedSet)

	@objc(removeProfiles:)
	@NSManaged public func removeFromProfiles(_ values: NSOrderedSet)
}
