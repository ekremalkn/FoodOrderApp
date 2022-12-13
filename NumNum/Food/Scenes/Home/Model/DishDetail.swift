//
//  DishDetail.swift
//  NumNum
//
//  Created by Ekrem Alkan on 13.12.2022.
//

import Foundation

// MARK: - DishDetail
struct DishDetail: Codable {
    let status: Int?
    let message: String?
    let data: [Dish]?
}

// MARK: - Datum
struct Dish: Codable {
    
    let id, name, datumDescription: String?
    let image: String?
    let calories: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case datumDescription = "description"
        case image, calories
    }
    
    
}


