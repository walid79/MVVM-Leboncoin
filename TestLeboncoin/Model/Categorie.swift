//
//  Categorie.swift
//  TestLeboncoin
//
//  Created by walid nakbi on 15/7/2021.
//

import Foundation
struct CatégorieElement: Codable {
    let id: Int
    let name: String

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

typealias Catégorie = [CatégorieElement]
