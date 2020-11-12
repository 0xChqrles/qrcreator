//
//  CoreDataAPIService.swift
//  attestation
//
//  Created by Charles Lanier on 06/11/2020.
//

import CoreData

class CoreDataAPIService: NSObject {

	func fetchEntities<T>(
		ofType: T.Type,
		withName entityName: String,
		withPredicate predicate: NSPredicate? = nil,
		sortedBy sorts: [NSSortDescriptor]? = nil
	) -> [T]? {
		let managedContext = CoreDataStorage.shared.persistentContainer.viewContext
		let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)

		fetchRequest.sortDescriptors = sorts
		fetchRequest.predicate = predicate
		do {
			let entities = try managedContext.fetch(fetchRequest) as? [T]
			return entities
		} catch {
			print(error.localizedDescription)
			return nil
		}
	}

	func clearStorage(forEntity entity: String, withPredicate predicate: NSPredicate? = nil) {
		let managedObjectContext = CoreDataStorage.shared.managedObjectContext
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)

		fetchRequest.predicate = predicate
		if CoreDataStorage.shared.isInMemoryStore {
			do {
				let entities = try managedObjectContext.fetch(fetchRequest)
				for entity in entities {
					if let entity = entity as? NSManagedObject {
						managedObjectContext.delete(entity)
					}
				}
			} catch {
				print(error.localizedDescription)
			}
		} else {
			let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
			do {
				try managedObjectContext.execute(batchDeleteRequest)
			} catch {
				print(error.localizedDescription)
			}
		}
	}
}
