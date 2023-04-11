//
//  ViewCodeProtocol.swift
//  Lyra
//
//  Created by Luiz Sena on 10/04/23.
//

import Foundation

protocol ViewCodeProtocol {
    func setUI()
    func setHierarchy()
    func setConstraints()
}

extension ViewCodeProtocol {
    func buildLayout() {
        setUI()
        setHierarchy()
        setConstraints()
    }
}
