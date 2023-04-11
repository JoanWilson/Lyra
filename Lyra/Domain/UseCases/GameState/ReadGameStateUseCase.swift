//
//  ReadGameStateUseCase.swift
//  Lyra
//
//  Created by Joan Wilson Oliveira on 11/04/23.
//

import Foundation

public protocol ReadGameStateUseCase {
    typealias Result = Swift.Result<GameState, Error>
    func read(_ gameState: GameState, completion: @escaping (Result) -> Void)
}
