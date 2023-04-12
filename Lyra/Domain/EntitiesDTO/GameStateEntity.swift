//
//  GameState.swift
//  Lyra
//
//  Created by Joan Wilson Oliveira on 11/04/23.
//

import Foundation

public struct GameStateEntity: Equatable {
    let id = UUID()
    var currentLevel: Int
    let creationDate: Date
    var runes: [RuneEntity]

    public init(currentLevel: Int, creationDate: Date, runes: [RuneEntity]) {
        self.currentLevel = currentLevel
        self.creationDate = creationDate
        self.runes = runes
    }

    public static func ==(lhs: GameStateEntity, rhs: GameStateEntity) -> Bool {
        return lhs.currentLevel == rhs.currentLevel &&
            lhs.creationDate == rhs.creationDate &&
            lhs.runes == rhs.runes
    }
}

