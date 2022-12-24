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

struct Dishes: Codable {
    let status: Int?
    let message: String?
    let data: [Dish]?
    
    
}

// MARK: - DataClass
struct DataClass: Codable {
    let categories: [Category]?
    let populars, specials: [Dish]?
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
struct Dish: Codable, DishesViewCellProtocol, SpecialDishesViewCellProtocol, DetailDishViewProtocol, CategoryDishesCellProtocol, SearchViewCellProtocol {

    let id, name, popularDescription, datumDescription: String?
    let image: String?
    let calories: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case popularDescription, datumDescription = "description"
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
    
    //MARK: -  SpecialDishesViewCellProtocol
    
    var specialImage: String {
        image ?? ""
    }
    
    var specialTitle: String {
        name ?? ""
        
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
        if popularDescription != nil {
            return popularDescription ?? ""
        } else if datumDescription != nil {
            return datumDescription ?? ""
        }
        return ""
        
        
    }
    
    //MARK: - CategoryDishesCellProtocol
    
    var categoryDishesImage: String {
        image ?? ""
    }
    
    var categoryTitleLabel: String {
        name ?? ""
    }
    
    var categoryCalorieLabel: String {
        if let calories = calories {
            return "\(calories)"
        }
        return ""
    }
    
    //MARK: - SearchViewCellProtocol
    
    var searchCellImage: String {
        image ?? ""
    }
    
    var searchTitleLabel: String {
        name ?? ""
    }
    
    var searchCalorieLabel: String {
        if let calories = calories {
            return "\(calories)" 
        }
        return ""
    }
    


    
    
    
}


