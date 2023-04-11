//
//  UpdateRuneUseCase.swift
//  Lyra
//
//  Created by Joan Wilson Oliveira on 11/04/23.
//

import Foundation

public protocol UpdateRuneUseCase {
    typealias Result = Swift.Result<Rune, Error>
    func update(_ rune: Rune, completion: @escaping (Result) -> Void)
}
