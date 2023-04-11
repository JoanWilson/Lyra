//
//  StateRepository.swift
//  Lyra
//
//  Created by Joan Wilson Oliveira on 11/04/23.
//

import Foundation

public protocol StateRepositoryProtocol {
    var storage: StorageProtocol { get }
}

public final class StateRepository: StateRepositoryProtocol {
    public var storage: StorageProtocol

    init(storage: StorageProtocol) {
        self.storage = storage
    }
}

extension StateRepository: AddRuneUseCase, RemoveRuneUseCase, UpdateRuneUseCase, ReadRuneUseCase {
    public func read(_ rune: Rune, completion: @escaping (ReadRuneUseCase.Result) -> Rune) {
        
    }

    public func add(_ rune: Rune, completion: @escaping (AddRuneUseCase.Result) -> Void) {

    }

    public func update(_ rune: Rune, completion: @escaping (UpdateRuneUseCase.Result) -> Void) {

    }

    public func remove(_ rune: Rune, completion: @escaping (RemoveRuneUseCase.Result) -> Void) {

    }
}

extension StateRepository: AddGameStateUseCase, RemoveGameStateUseCase, UpdateGameStateUseCase, ReadGameStateUseCase {
    public func read(_ gameState: GameState, completion: @escaping (ReadGameStateUseCase.Result) -> Void) {

    }

    public func add(_ gameState: GameState, completion: @escaping (AddGameStateUseCase.Result) -> Void) {

    }

    public func update(_ gameState: GameState, completion: @escaping (UpdateGameStateUseCase.Result) -> Void) {

    }

    public func remove(_ gameState: GameState, completion: @escaping (RemoveGameStateUseCase.Result) -> Void) {

    }
}


