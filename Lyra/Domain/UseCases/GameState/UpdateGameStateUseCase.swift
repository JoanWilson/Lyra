//
//  UpdateGameStateUseCase.swift
//  Lyra
//
//  Created by Joan Wilson Oliveira on 11/04/23.
//

import Foundation

public protocol UpdateGameStateUseCase {
    typealias Result = Swift.Result<GameState, Error>
    func update(_ gameState: GameState, completion: @escaping (Result) -> Void)
}



