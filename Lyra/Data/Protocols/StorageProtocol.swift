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
    func updateGameState(_ gameState: GameStateEntity, uuid: UUID) -> GameStateEntity?
    func createRune(with rune: RuneEntity?) -> RuneEntity?
    func getRuneByUUID(_ uuid: UUID) -> RuneEntity?
    func getAllRunes() -> [RuneEntity]
    func removeRune(with rune: RuneEntity) -> Bool
}
