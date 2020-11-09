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

	lazy var isInMemoryStore: Bool = {
		let isInMemoryStore = persistentContainer.persistentStoreDescriptions.reduce(false) {
			return $0 ? true : $1.type == NSInMemoryStoreType
		}

		return isInMemoryStore
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
}
