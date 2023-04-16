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

    // MARK: - GetByID Methods
    public func getGameStateByUUID(_ uuid: UUID) -> GameState? {
        let fetchRequest: NSFetchRequest<GameState> = GameState.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", uuid as CVarArg)
        do {
            let results = try container.viewContext.fetch(fetchRequest)
            guard let objectFound = results.first else {
                print("Found nil fetching GameStates")
                return nil
            }
            return objectFound
        } catch {
            print("Fetch unabled")
            return nil
        }
    }

    public func getRuneUUID(_ uuid: UUID) -> Rune? {
        let fetchRequest: NSFetchRequest<Rune> = Rune.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", uuid as CVarArg)
        do {
            let results = try container.viewContext.fetch(fetchRequest)
            guard let objectFound = results.first else {
                print("Found nil fetching Runes")
                return nil
            }
            return objectFound
        } catch {
            print("Fetch unabled")
            return nil
        }
    }


    // MARK: - Comparasion Methods
    public func compareGameStates(gameState: GameState?, gameStateEntity: GameStateEntity?) -> GameStateEntity? {
        guard let gameState = gameState else {
            print("GameState argument is Nil")
            return nil
        }

        guard let gameStateEntity = gameStateEntity else {
            print("GameStateEntity argument is Nil")
            return nil
        }

        guard let savedCreationDate = gameState.creationDate  else {
            print("Saved gameState has nil attributes")
            return nil
        }

        if gameState.id == gameStateEntity.id,
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


    // MARK: - Converter Methods
    public func convertGameStateCoreDataToEntity(gameState: GameState?) -> GameStateEntity? {
        guard let gameState = gameState else {
            print("GameState argument is Nil")
            return nil
        }

        guard let savedId = gameState.id,
              let savedCreationDate = gameState.creationDate else {
            print("Saved gameState has nil attributes")
            return nil
        }

        return GameStateEntity(id: savedId, currentLevel: Int(gameState.currentLevel), creationDate: savedCreationDate)
    }

    public func convertRuneCoreDataToEntity(rune: Rune?) -> RuneEntity? {
        guard let rune = rune else {
            print("Rune argument is Nil")
            return nil
        }


        let savedOrderId = Int32(rune.orderId)
        let savedEffect = Int(rune.effect)

        guard let savedId = rune.id,
              let savedName = rune.name else {
            print("Saved rune has nil attributes")
            return nil
        }

        return RuneEntity(id: savedId, name: savedName, effect: savedEffect, orderId: savedOrderId)
    }

    // MARK: - Save Methods
    internal func saveContext() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }

    internal func saveGameStateOptional(_ gameState: GameState) -> GameStateEntity? {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
                return convertGameStateCoreDataToEntity(gameState: gameState)
            } catch {
                print("It wasnt possible to save Core Data Context")
                return nil
            }
        } else {
            print("There is no changed to save in CoreData")
            return nil
        }
    }

    internal func saveRuneOptional(_ rune: Rune) -> RuneEntity? {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
                return convertRuneCoreDataToEntity(rune: rune)
            } catch {
                print("It wasnt possible to save Core Data Context")
                return nil
            }
        } else {
            print("There is no changed to save in CoreData")
            return nil
        }
    }

    internal func saveContextWithBool() -> Bool {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
                return true
            } catch {
                print("It wasnt possible to save Core Data Context")
                return false
            }
        } else {
            print("There is no changed to save in CoreData")
            return false
        }
    }


}

