//
//  StorageProtocol.swift
//  Lyra
//
//  Created by Joan Wilson Oliveira on 11/04/23.
//

import Foundation

public protocol StorageProtocol {
    func createGameState(with gameState: GameStateEntity) -> Bool
    func removeGameState(with gameState: GameStateEntity) -> Bool
    func updateGameState(with gameState: GameStateEntity) -> GameStateEntity
    func addRune(with rune: RuneEntity) -> Bool
    func removeRune(with rune: RuneEntity) -> Bool
    func updateRune(with rune: RuneEntity) -> RuneEntity
}
