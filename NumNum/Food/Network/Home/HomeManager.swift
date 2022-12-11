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
}

class HomeManager: HomeManagerProtocol {
    static let shared = HomeManager()
    
    func getCategoryFoods(type: HomeEndpoint, onSuccess: @escaping(Foods?) -> (), onError: @escaping (AFError) -> ()) {
        var url = ""
        
        switch type {
        case .fetchAllCategories:
            url = HomeEndpoint.fetchAllCategories.path
        case .placeOrder:
            url = HomeEndpoint.placeOrder.path
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
