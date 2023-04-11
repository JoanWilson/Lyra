//
//  RemoveGameStateUseCase.swift
//  Lyra
//
//  Created by Joan Wilson Oliveira on 11/04/23.
//

import Foundation

public protocol RemoveGameStateUseCase {
    typealias Result = Swift.Result<Bool, Error>
    func remove(_ gameState: GameState, completion: @escaping (Result) -> Void)
}
