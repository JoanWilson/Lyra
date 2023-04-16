//
//  GameState.swift
//  Lyra
//
//  Created by Joan Wilson Oliveira on 11/04/23.
//

import Foundation

public struct GameStateEntity: Equatable {
    public let id: UUID
    public var currentLevel: Int
    public let creationDate: Date

    public init(id: UUID, currentLevel: Int, creationDate: Date) {
        self.id = id
        self.currentLevel = currentLevel
        self.creationDate = creationDate
    }

    public static func ==(lhs: GameStateEntity, rhs: GameStateEntity) -> Bool {
        return lhs.currentLevel == rhs.currentLevel &&
            lhs.creationDate == rhs.creationDate 
    }
}

