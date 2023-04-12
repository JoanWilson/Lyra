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

    public func getGameStateByUUID(_ uuid: UUID) -> GameStateEntity? {
    nil
    }

    public func getAllGameStates() -> [GameStateEntity] {
        []
    }

    public func removeGameState(with gameState: GameStateEntity) -> Bool {

        return true
    }

    public func updateGameState(with gameState: GameStateEntity) -> GameStateEntity? {
        return GameStateEntity(id: UUID(), currentLevel: 0, creationDate: Date(), runes: [])
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
        return RuneEntity(id: UUID(), name: "", effect: 0)
    }
}
