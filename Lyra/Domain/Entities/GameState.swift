//
//  GameState.swift
//  Lyra
//
//  Created by Joan Wilson Oliveira on 11/04/23.
//

import Foundation

public struct GameState {
    let uuid = UUID()
    var currentLevel: Int
    let creationDate: Date
    var runes: [Rune]

    public init(currentLevel: Int, creationDate: Date, runes: [Rune]) {
        self.currentLevel = currentLevel
        self.creationDate = creationDate
        self.runes = runes
    }
}
