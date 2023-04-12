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

    // MARK: - Private Methods
    public func compareGameStates(gameState: GameState?, gameStateEntity: GameStateEntity?) -> GameStateEntity? {
        guard let gameState = gameState else {
            print("GameState argument is Nil")
            return nil
        }

        guard let gameStateEntity = gameStateEntity else {
            print("GameStateEntity argument is Nil")
            return nil
        }

        guard let savedRunes = gameState.runes?.allObjects as? [RuneEntity] else {
            print("Saved gameState has nil Runes")
            return nil
        }

        guard let savedCreationDate = gameState.creationDate else {
            print("Saved gameState has nil creationDate")
            return nil
        }

        let savedGameState = GameStateEntity(
            currentLevel: Int(gameState.currentLevel),
            creationDate: savedCreationDate,
            runes: savedRunes
        )

        if gameState.id == gameStateEntity.id,
           savedRunes == gameStateEntity.runes,
           savedCreationDate == gameStateEntity.creationDate,
           gameState.currentLevel == Int32(gameStateEntity.currentLevel) {
            return gameStateEntity
        } else {
            return nil
        }
    }

    public func compareRunes() -> RuneEntity? {
        return nil
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
            return compareGameStates(gameState: entity, gameStateEntity: gameState)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    public func removeGameState(with gameState: GameStateEntity) -> Bool {
        return false
    }

    public func updateGameState(with gameState: GameStateEntity) -> GameStateEntity? {
        return GameStateEntity(currentLevel: 0, creationDate: Date(), runes: [])
    }

    public func addRune(with rune: RuneEntity) -> RuneEntity? {
        return nil
    }

    public func removeRune(with rune: RuneEntity) -> Bool {
        return true
    }

    public func updateRune(with rune: RuneEntity) -> RuneEntity? {
        return RuneEntity(name: "", effect: 0)
    }
}
