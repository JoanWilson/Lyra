//
//  RemoveRuneUseCase.swift
//  Lyra
//
//  Created by Joan Wilson Oliveira on 11/04/23.
//

import Foundation

public protocol RemoveRuneUseCase {
    typealias Result = Swift.Result<Bool, Error>
    func remove(_ rune: RuneEntity, completion: @escaping (Result) -> Void)
}
