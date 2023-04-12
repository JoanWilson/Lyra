//
//  CoreDataStorage.swift
//  Lyra
//
//  Created by Joan Wilson Oliveira on 11/04/23.
//

import CoreData

public struct CoreDataPersistentContainer {
    var container: NSPersistentContainer

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

    public func compareGameStates(gameState: GameState?, gameStateEntity: GameStateEntity?) -> GameStateEntity? {
        guard let gameState = gameState else {
            print("GameState argument is Nil")
            return nil
        }

        guard let gameStateEntity = gameStateEntity else {
            print("GameStateEntity argument is Nil")
            return nil
        }

        guard let savedRunes = gameState.runes?.allObjects as? [RuneEntity],
            let savedCreationDate = gameState.creationDate  else {
            print("Saved gameState has nil attributes")
            return nil
        }

        if gameState.id == gameStateEntity.id,
           savedRunes == gameStateEntity.runes,
           savedCreationDate == gameStateEntity.creationDate,
           gameState.currentLevel == Int32(gameStateEntity.currentLevel) {
            return gameStateEntity
        } else {
            return nil
        }
    }

    public func compareRunes(rune: Rune?, runeEntity: RuneEntity?) -> RuneEntity? {
        guard let rune = rune else {
            print("Rune argument is Nil")
            return nil
        }

        guard let runeEntity = runeEntity else {
            print("RuneEntity argument is Nil")
            return nil
        }

        if rune.effect == Int32(runeEntity.effect),
           rune.name == runeEntity.name,
           rune.id == runeEntity.id {
            return runeEntity
        } else {
            return nil
        }
    }
}

