//
//  Foods.swift
//  NumNum
//
//  Created by Ekrem Alkan on 4.12.2022.
//

import Foundation

// MARK: - Foods
struct Foods: Codable {
    let status: Int?
    let message: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let categories: [Category]?
    let populars, specials: [Popular]?
}

// MARK: - Category
struct Category: Codable, CategoryViewCellProtocol {
    let id, title: String?
    let image: String?
    
    //MARK: - CategoryCellProtocol
    var categoryCellİmage: String {
        image ?? ""
    }
    
    var catergoryCellLabel: String {
        title ?? ""
    }
    

}

// MARK: - Popular
struct Popular: Codable {
    let id, name, popularDescription: String?
    let image: String?
    let calories: Int?

    enum CodingKeys: String, CodingKey {
        case id, name
        case popularDescription = "description"
        case image, calories
    }
}
