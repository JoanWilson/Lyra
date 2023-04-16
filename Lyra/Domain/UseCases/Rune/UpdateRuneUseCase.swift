//
//  UpdateRuneUseCase.swift
//  Lyra
//
//  Created by Joan Wilson Oliveira on 11/04/23.
//

import Foundation

public protocol UpdateRuneUseCase {
    typealias Result = Swift.Result<RuneEntity, Error>
    func update(_ rune: RuneEntity, completion: @escaping (Result) -> Void)
}
