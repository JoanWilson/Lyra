//
//  Rune.swift
//  Lyra
//
//  Created by Joan Wilson Oliveira on 11/04/23.
//

import Foundation

public struct RuneEntity: Equatable {
    let id = UUID()
    let name: String
    let effect: Int

    public init(name: String, effect: Int) {
        self.name = name
        self.effect = effect
    }

    public static func ==(lhs: RuneEntity, rhs: RuneEntity) -> Bool {
        return lhs.name == rhs.name &&
            lhs.effect == rhs.effect
    }
}

