//
//  Rune.swift
//  Lyra
//
//  Created by Joan Wilson Oliveira on 11/04/23.
//

import Foundation

public struct RuneEntity: Equatable {
    public let id: UUID
    public var name: String
    public var effect: Int

    public init(id: UUID, name: String, effect: Int) {
        self.id = id
        self.name = name
        self.effect = effect
    }

    public static func ==(lhs: RuneEntity, rhs: RuneEntity) -> Bool {
        return lhs.name == rhs.name &&
            lhs.effect == rhs.effect
    }
}

