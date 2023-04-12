//
//  CoreDataManager.swift
//  Lyra
//
//  Created by Joan Wilson Oliveira on 11/04/23.
//

import CoreData

public final class CoreDataStorage: StorageProtocol {

    private var container: CoreDataPersistentContainer

    public init(container: CoreDataPersistentContainer) {
        self.container = container
    }

    public func createGameState(with gameState: GameStateEntity) -> Bool {
        
        return true
    }

    public func removeGameState(with gameState: GameStateEntity) -> Bool {
        return true
    }

    public func updateGameState(with gameState: GameStateEntity) -> GameStateEntity {
        return GameStateEntity(currentLevel: 0, creationDate: Date(), runes: [])
    }

    public func addRune(with rune: RuneEntity) -> Bool {
        return true
    }

    public func removeRune(with rune: RuneEntity) -> Bool {
        return true
    }

    public func updateRune(with rune: RuneEntity) -> RuneEntity {
        return RuneEntity(name: "", effect: 0)
    }
}
