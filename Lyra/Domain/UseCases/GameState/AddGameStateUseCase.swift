//
//  StateUseCase.swift
//  Lyra
//
//  Created by Joan Wilson Oliveira on 11/04/23.
//

import Foundation

public protocol AddGameStateUseCase {
    typealias Result = Swift.Result<Bool, Error>
    func add(_ gameState: GameState, completion: @escaping (Result) -> Void)
}
