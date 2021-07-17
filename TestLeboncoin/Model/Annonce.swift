//
//  Annonce.swift
//  TestLeboncoin
//
//  Created by walid nakbi on 14/7/2021.
//

import UIKit
struct AnnonceElement:Codable{
    let id, categoryID: Int
    let title, annonceDescription: String
    let price: Int
    let imagesURL: ImagesURL
    let creationDate: String
    let isUrgent: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case title
        case annonceDescription = "description"
        case price
        case imagesURL = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
    }

    init(id: Int, categoryID: Int, title: String, annonceDescription: String, price: Int, imagesURL: ImagesURL, creationDate: String, isUrgent: Bool) {
            self.id = id
            self.categoryID = categoryID
            self.title = title
            self.annonceDescription = annonceDescription
            self.price = price
            self.imagesURL = imagesURL
            self.creationDate = creationDate
            self.isUrgent = isUrgent
        }
}

// MARK: - ImagesURL
struct ImagesURL: Codable {
    let small, thumb: String?
  
    init(small: String, thumb: String) {
            self.small = small
            self.thumb = thumb
        }
   
}

typealias Annonce = [AnnonceElement]
