//
//  HomeManager.swift
//  NumNum
//
//  Created by Ekrem Alkan on 4.12.2022.
//

import Foundation
import Alamofire

protocol HomeManagerProtocol {
    func getCategoryFoods(type: HomeEndpoint, onSuccess: @escaping(Foods?) -> (), onError: @escaping(AFError) -> ())
    func getDetailDishes(type: HomeEndpoint, onSuccess: @escaping(DishDetail?) -> (), onError: @escaping(AFError) -> ())
    
}

class HomeManager: HomeManagerProtocol {
    func getDetailDishes(type: HomeEndpoint, onSuccess: @escaping (DishDetail?) -> (), onError: @escaping (Alamofire.AFError) -> ()) {
        var url = ""
        
        switch type {
            
        case .fetchAllCategories:
            url = HomeEndpoint.fetchAllCategories.path
        case .placeOrder(let dishID):
            url = HomeEndpoint.placeOrder(dishID).path
        case .fetchCategoryDishes(let catID):
            url = HomeEndpoint.fetchCategoryDishes(catID).path
            
        case .fetchOrders:
            url = HomeEndpoint.fetchOrders.path
        }
        
        NetworkManager.shared.request(path: url) { (response: DishDetail) in
            onSuccess(response)
            
        } onError: { error in
            onError(error)
        }
    }
    
    static let shared = HomeManager()
    
    func getCategoryFoods(type: HomeEndpoint, onSuccess: @escaping(Foods?) -> (), onError: @escaping (AFError) -> ()) {
        var url = ""
        
        switch type {
            
        case .fetchAllCategories:
            url = HomeEndpoint.fetchAllCategories.path
        case .placeOrder(let dishID):
            url = HomeEndpoint.placeOrder(dishID).path
        case .fetchCategoryDishes(let catID):
            url = HomeEndpoint.fetchCategoryDishes(catID).path
            
        case .fetchOrders:
            url = HomeEndpoint.fetchOrders.path
        }
        
        NetworkManager.shared.request(path: url) { (response: Foods) in
            onSuccess(response)
            
        } onError: { error in
            onError(error)
        }
        
        
    }
    
    
    
    
}
