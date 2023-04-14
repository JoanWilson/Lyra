//
//  CoreDataManager.swift
//  Lyra
//
//  Created by Joan Wilson Oliveira on 11/04/23.
//

import CoreData

public final class CoreDataStorage: StorageProtocol {

    public var container: CoreDataPersistentContainer

    public init(container: CoreDataPersistentContainer) {
        self.container = container
    }

    public func createGameState(with gameState: GameStateEntity?) -> GameStateEntity? {
        let entity = GameState(context: container.viewContext)
        guard let gameState = gameState else {
            return nil
        }

        entity.id = gameState.id
        entity.runes?.addingObjects(from: gameState.runes)
        entity.currentLevel = Int32(gameState.currentLevel)
        entity.creationDate = gameState.creationDate
        print(entity)

        do  {
            try container.viewContext.save()
            return container.compareGameStates(gameState: entity, gameStateEntity: gameState)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

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

    public func getAllGameStates() -> [GameStateEntity] {
        let fetchRequest: NSFetchRequest<GameState> = GameState.fetchRequest()
        do {
            let results = try container.viewContext.fetch(fetchRequest)
            var convertedResults = [GameStateEntity]()
            for game in results {
                guard let convertedGame = container.convertGameStateCoreDataToEntity(gameState: game) else {
                    print("Impossible to convert fetched GameState to GameState Entity")
                    return []
                }
                convertedResults.append(convertedGame)
            }
            return convertedResults
        } catch {
            print("Impossible to fetch results")
            return []
        }
    }

    public func removeGameState(with gameState: GameStateEntity) -> Bool {
        guard let objectFound = getGameStateByUUID(gameState.id) else {
            print("Object didnt found in CoreData, not possible to delete")
            return false
        }
        container.viewContext.delete(objectFound)

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

    public func updateGameState(_ gameState: GameStateEntity, uuid: UUID) -> GameStateEntity? {
        guard let objectFound = getGameStateByUUID(uuid) else {
            return nil
        }

        objectFound.currentLevel = Int32(gameState.currentLevel)
        var runesConverted = NSOrderedSet()
        for runeEntity in gameState.runes {
            let rune: Rune = Rune(context: container.viewContext)
            rune.id = runeEntity.id
            rune.orderId = runeEntity.orderId
            rune.name = runeEntity.name
            rune.effect = Int32(runeEntity.effect)
            runesConverted.set
        }

        objectFound.runes = runesConverted

        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
                return container.convertGameStateCoreDataToEntity(gameState: objectFound)
            } catch {
                print("It wasnt possible to save Core Data Context")
                return nil
            }
        } else {
            print("There is no changed to save in CoreData")
            return nil
        }
    }

    public func createRune(with rune: RuneEntity?) -> RuneEntity? {
        return nil
    }


    public func getRuneByUUID(_ uuid: UUID) -> RuneEntity? {
        nil
    }

    public func getAllRunes() -> [RuneEntity] {
        []
    }


    public func removeRune(with rune: RuneEntity) -> Bool {
        return true
    }

    public func updateRune(with rune: RuneEntity) -> RuneEntity? {
        return RuneEntity(id: UUID(), name: "", effect: 0, orderId: 0)
    }
}
