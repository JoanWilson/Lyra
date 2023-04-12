//
//  ReadRuneUseCase.swift
//  Lyra
//
//  Created by Joan Wilson Oliveira on 11/04/23.
//

import Foundation

public protocol ReadRuneUseCase {
    typealias Result = Swift.Result<RuneEntity, Error>
    func read(_ rune: RuneEntity, completion: @escaping (Result) -> RuneEntity)
}
