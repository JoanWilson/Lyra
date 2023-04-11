//
//  StorageProtocol.swift
//  Lyra
//
//  Created by Joan Wilson Oliveira on 11/04/23.
//

import Foundation

public protocol StorageProtocol {
    func createGameState(with gameState: GameState) -> Bool
    func removeGameState(with gameState: GameState) -> Bool
    func updateGameState(with gameState: GameState) -> GameState
    func addRune(with rune: Rune) -> Bool
    func removeRune(with rune: Rune) -> Bool
    func updateRune(with rune: Rune) -> Rune
}
