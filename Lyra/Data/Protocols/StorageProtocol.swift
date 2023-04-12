//
//  StorageProtocol.swift
//  Lyra
//
//  Created by Joan Wilson Oliveira on 11/04/23.
//

import Foundation

public protocol StorageProtocol {
    func createGameState(with gameState: GameStateEntity?) -> GameStateEntity?
    func getGameStateByUUID(_ uuid: UUID) -> GameStateEntity?
    func getAllGameStates() -> [GameStateEntity]
    func removeGameState(with gameState: GameStateEntity) -> Bool
    func updateGameState(with gameState: GameStateEntity) -> GameStateEntity?
    func createRune(with rune: RuneEntity?) -> RuneEntity?
    func getRuneByUUID(_ uuid: UUID) -> RuneEntity?
    func getAllRunes() -> [RuneEntity]
    func removeRune(with rune: RuneEntity) -> Bool
    func updateRune(with rune: RuneEntity) -> RuneEntity?
}
