//
//  HomeHelper.swift
//  NumNum
//
//  Created by Ekrem Alkan on 4.12.2022.
//

import Foundation

enum HomeEndpoint {
    case fetchAllCategories
    case fetchCategoryDishes(String)
    
    var path: String {
        switch self {
        case .fetchAllCategories:
            return NetworkHelper.shared.requestUrl(url: "/dish-categories")
        case .fetchCategoryDishes(let catID):
            return NetworkHelper.shared.requestUrl(url: "/dishes/\(catID)")
        }
    }
}


