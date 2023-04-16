//
//  LevelsViewModel.swift
//  Lyra
//
//  Created by Paulo Henrique Gomes da Silva on 14/04/23.
//

import Foundation

class LevelsViewModel: ObservableObject {
    @Published var images = ["moon", "planet1", "planet2", "planet3"]
    @Published var idle: Bool = false
}
