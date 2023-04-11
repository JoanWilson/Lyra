//
//  CoreDataManager.swift
//  Lyra
//
//  Created by Joan Wilson Oliveira on 11/04/23.
//

import CoreData

public final class CoreDataStorage: StorageProtocol {

    private var container: CoreDataPersistentContainer

    init(container: CoreDataPersistentContainer) {
        self.container = container
    }

    public func createGameState(with gameState: GameState) -> Bool {
        return true
    }

    public func removeGameState(with gameState: GameState) -> Bool {
        return true
    }

    public func updateGameState(with gameState: GameState) -> GameState {
        return GameState(currentLevel: 0, creationDate: Date(), runes: [])
    }

    public func addRune(with rune: Rune) -> Bool {
        return true
    }

    public func removeRune(with rune: Rune) -> Bool {
        return true
    }

    public func updateRune(with rune: Rune) -> Rune {
        return Rune(name: "", effect: 0)
    }
}
