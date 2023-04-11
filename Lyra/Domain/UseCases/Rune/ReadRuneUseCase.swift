//
//  ReadRuneUseCase.swift
//  Lyra
//
//  Created by Joan Wilson Oliveira on 11/04/23.
//

import Foundation

public protocol ReadRuneUseCase {
    typealias Result = Swift.Result<Rune, Error>
    func read(_ rune: Rune, completion: @escaping (Result) -> Rune)
}
