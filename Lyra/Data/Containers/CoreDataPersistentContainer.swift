//
//  CoreDataStorage.swift
//  Lyra
//
//  Created by Joan Wilson Oliveira on 11/04/23.
//

import CoreData

public struct CoreDataPersistentContainer {
    let container: NSPersistentContainer

    static let shared = CoreDataPersistentContainer()

    // Convenience
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }

    static var preview: CoreDataPersistentContainer = {
        let result = CoreDataPersistentContainer(inMemory: true)
        let viewContext = result.container.viewContext
        return result
    }()

    public init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "StateDatabase") // else UnsafeRawBufferPointer with negative count
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }

    // Better save
    func saveContext() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
}

