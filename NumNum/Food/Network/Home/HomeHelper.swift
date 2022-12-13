//
//  HomeHelper.swift
//  NumNum
//
//  Created by Ekrem Alkan on 4.12.2022.
//

import Foundation

enum HomeEndpoint {
    case fetchAllCategories
    case placeOrder(String)
    case fetchCategoryDishes(String)
    case fetchOrders
    
    var path: String {
        switch self {
        case .fetchAllCategories:
            return NetworkHelper.shared.requestUrl(url: "/dish-categories")
        case .placeOrder(let dishID):
            return NetworkHelper.shared.requestUrl(url: "/orders/\(dishID)")
        case .fetchCategoryDishes(let catID):
            return NetworkHelper.shared.requestUrl(url: "/dishes/\(catID)")
        case .fetchOrders:
            return NetworkHelper.shared.requestUrl(url: "/orders")
        }
    }
}


