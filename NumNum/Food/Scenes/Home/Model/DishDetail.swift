
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
struct Dish: Codable, DishesViewCellProtocol, DetailDishViewProtocol {
    
    let id, name, datumDescription: String?
    let image: String?
    let calories: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case datumDescription = "description"
        case image, calories
    }
    
    //MARK: - DishesViewCellProtocol
    
    var dishesCellImage: String {
        image ?? ""
    }
    
    var dishesCellTitle: String {
        name ?? ""
    }
    
    var dishesCellCalorie: String {
        if let calories = calories {
            return "\(calories)"
        }
        return ""
    }
    
    var dishesCellDescription: String {
        datumDescription ?? ""
        
    }
    
    //MARK: - DetailDishViewProtocol
    
    var detailİmage: String {
        image ?? ""
    }
    
    var detailTitle: String {
        name ?? ""
        
    }
    
    var detailCalorie: String {
        if let calories = calories {
            return "\(calories)"
        }
        return ""
        
    }
    
    var detailDescription: String {
        datumDescription ?? ""
        
    }
    
    
}


