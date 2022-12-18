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
    let populars, specials: [Dishes]?
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

// MARK: - Dish
struct Dishes: Codable, DishesViewCellProtocol, SpecialDishesViewCellProtocol, DetailDishViewProtocol {
    
    
    let id, name, popularDescription: String?
    let image: String?
    let calories: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case popularDescription = "description"
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
        popularDescription ?? ""
        
    }
    
    //MARK: -  SpecialDishesViewCellProtocol
    
    var specialImage: String {
        image ?? ""
    }
    
    var specialTitle: String {
        name ?? ""
        
    }
    
    var specialDescription: String {
        popularDescription ?? ""
        
    }
    
    var specialCalorie: String {
        if let calories = calories {
            return "\(calories)"
        }
        return ""
        
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
        popularDescription ?? ""
        
    }
    

    
}


