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
    public func read(_ rune: RuneEntity, completion: @escaping (ReadRuneUseCase.Result) -> RuneEntity) {
        
    }

    public func add(_ rune: RuneEntity, completion: @escaping (AddRuneUseCase.Result) -> Void) {

    }

    public func update(_ rune: RuneEntity, completion: @escaping (UpdateRuneUseCase.Result) -> Void) {

    }

    public func remove(_ rune: RuneEntity, completion: @escaping (RemoveRuneUseCase.Result) -> Void) {

    }
}

extension StateRepository: AddGameStateUseCase, RemoveGameStateUseCase, UpdateGameStateUseCase, ReadGameStateUseCase {

    public func read(_ gameState: GameStateEntity, completion: @escaping (ReadGameStateUseCase.Result) -> Void) {

    }

    public func add(_ gameState: GameStateEntity, completion: @escaping (AddGameStateUseCase.Result) -> Void) {

    }

    public func update(_ gameState: GameStateEntity, completion: @escaping (UpdateGameStateUseCase.Result) -> Void) {

    }

    public func remove(_ gameState: GameStateEntity, completion: @escaping (RemoveGameStateUseCase.Result) -> Void) {

    }
}


