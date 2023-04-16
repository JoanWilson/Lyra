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
        entity.currentLevel = Int32(gameState.currentLevel)
        entity.creationDate = gameState.creationDate
        return container.saveGameStateOptional(entity)
    }

    public func getGameStateByUUID(_ uuid: UUID) -> GameStateEntity? {
        let stateFound = container.getGameStateByUUID(uuid)
        return container.convertGameStateCoreDataToEntity(gameState: stateFound)
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
        guard let objectFound = container.getGameStateByUUID(gameState.id) else {
            print("Object didnt found in CoreData, not possible to delete")
            return false
        }
        container.viewContext.delete(objectFound)
        return container.saveContextWithBool()
    }

    public func updateGameState(_ gameState: GameStateEntity, uuid: UUID) -> GameStateEntity? {
        guard let objectFound = container.getGameStateByUUID(uuid) else {
            return nil
        }
        objectFound.currentLevel = Int32(gameState.currentLevel)
        return container.saveGameStateOptional(objectFound)
    }

    public func createRune(with rune: RuneEntity?) -> RuneEntity? {
        let entity = Rune(context: container.viewContext)
        guard let rune = rune else {
            return nil
        }

        entity.id = rune.id
        entity.effect = Int32(rune.effect)
        entity.orderId = rune.orderId
        entity.name = rune.name

        return container.saveRuneOptional(entity)
    }


    public func getRuneByUUID(_ uuid: UUID) -> RuneEntity? {
        let runeFound = container.getRuneUUID(uuid)
        return container.convertRuneCoreDataToEntity(rune: runeFound)
    }

    public func getAllRunes() -> [RuneEntity] {
        let fetchRequest: NSFetchRequest<Rune> = Rune.fetchRequest()
        do {
            let results = try container.viewContext.fetch(fetchRequest)
            var convertedResults = [RuneEntity]()
            for rune in results {
                guard let convertedRune = container.convertRuneCoreDataToEntity(rune: rune) else {
                    print("Impossible to convert fetched Rune to Rune Entity")
                    return []
                }
                convertedResults.append(convertedRune)
            }
            return convertedResults
        } catch {
            print("Impossible to fetch results")
            return []
        }
    }


    public func removeRune(with rune: RuneEntity) -> Bool {
        guard let objectFound = container.getRuneUUID(rune.id) else {
            print("Object didnt found in CoreData, not possible to delete")
            return false
        }
        container.viewContext.delete(objectFound)
        return container.saveContextWithBool()
    }
}
