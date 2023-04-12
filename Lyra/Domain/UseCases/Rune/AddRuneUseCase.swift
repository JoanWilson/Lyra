//
//  RuneUseCase.swift
//  Lyra
//
//  Created by Joan Wilson Oliveira on 11/04/23.
//

import Foundation

public protocol AddRuneUseCase {
    typealias Result = Swift.Result<Bool, Error>
    func add(_ rune: RuneEntity, completion: @escaping (Result) -> Void)
}
