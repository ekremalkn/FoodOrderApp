//
//  SearchViewModel.swift
//  NumNum
//
//  Created by Ekrem Alkan on 20.12.2022.
//

import Foundation

class SearchViewModel {
    
    let manager = HomeManager.shared
    
    var searchCategories = [Category]()
    var searchDishes = [Dish]()
    
    var errorCallback: ((String)->())?
    var successCallback: (()->())?
    
    
    //MARK: - Getting Categories for Search scene
    
    func getSearchCategory() {
        manager.getCategoryFoods(type: .fetchAllCategories) { foods in
            if let foods = foods {
                self.searchCategories = foods.data?.categories ?? []
                self.successCallback?()
            }
            
        } onError: { error in
            print("Error while getting Category Data\(error)")
        }
        
    }
    
    //MARK: - Getting Dishes for Search scene
    
    func getSearchDishes(catID: String) {
        manager.getDetailDishes(type: .fetchCategoryDishes(catID)) { foods in
            if let foods = foods {
                self.searchDishes = foods.data ?? []
                self.successCallback?()
            }
        } onError: { error in
            print("Error while getting dishes for Search scene. ")
        }
        
    }
    
}
