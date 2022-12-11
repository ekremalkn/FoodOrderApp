//
//  HomeHelper.swift
//  NumNum
//
//  Created by Ekrem Alkan on 4.12.2022.
//

import Foundation

enum FoodCategory {
    case snacks
    case pizzas
    case nigerianDishes
    case vegetarian
    case seaFoods
}

enum HomeEndpoint: String {
    case fetchAllCategories = "/dish-categories"
    case placeOrder = "/orders/"
    //case fetchCategoryDishes = "/dishes/\(categoryId)"
    case fetchOrders = "/orders"
    
    var path: String {
        switch self {
        case .fetchAllCategories:
            return NetworkHelper.shared.requestUrl(url: HomeEndpoint.fetchAllCategories.rawValue)
        case .placeOrder:
            return NetworkHelper.shared.requestUrl(url: HomeEndpoint.placeOrder.rawValue)
       // case .fetchCategoryDishes:
        //    return NetworkHelper.shared.requestUrl(url: HomeEndpoint.fetchCategoryDishes.rawValue)
        case .fetchOrders:
            return NetworkHelper.shared.requestUrl(url: HomeEndpoint.fetchOrders.rawValue)
        }
    }
}
