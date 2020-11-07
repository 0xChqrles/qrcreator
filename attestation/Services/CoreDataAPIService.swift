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
		completion: @escaping (([T]?, Error?) -> ())
	) {
		let managedContext = CoreDataStorage.shared.persistentContainer.viewContext
		let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)

		do {
			let entities = try managedContext.fetch(fetchRequest) as? [T]
			completion(entities, nil)
		} catch {
			completion(nil, error)
		}
	}
}
