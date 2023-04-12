//
//  Rune.swift
//  Lyra
//
//  Created by Joan Wilson Oliveira on 11/04/23.
//

import Foundation

public struct RuneEntity {
    let id = UUID()
    let name: String
    let effect: Int

    public init(name: String, effect: Int) {
        self.name = name
        self.effect = effect
    }
}
