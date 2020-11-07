//
//  CoreDataStorage.swift
//  attestation
//
//  Created by Charles Lanier on 05/11/2020.
//

import CoreData

class CoreDataStorage: NSObject {

	// Singleton
	static let shared = CoreDataStorage()

	// MARK: - Public Properties
	lazy var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "CoreDataStorage")
		container.loadPersistentStores { storeCompletion, error in
			if let error = error {
				print(error.localizedDescription)
			}
		}
		return container
	}()

	lazy var managedObjectContext: NSManagedObjectContext = {
		return persistentContainer.viewContext
	}()

	lazy var apiService: CoreDataAPIService = {
		return CoreDataAPIService()
	}()

	// MARK: - Initialization
	private override init() { }

	// MARK: - Public Methods
	func saveContext() {
		let context = persistentContainer.viewContext
		if context.hasChanges {
			do {
				try context.save()
			} catch {
				print(error.localizedDescription)
			}
		}
	}

	func clearStorage(forEntity entity: String) {
		let isInMemoryStore = persistentContainer.persistentStoreDescriptions.reduce(false) {
			return $0 ? true : $1.type == NSInMemoryStoreType
		}

		let managedObjectContext = persistentContainer.viewContext
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
		// NSBatchDeleteRequest is not supported for in-memory stores
		if isInMemoryStore {
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
