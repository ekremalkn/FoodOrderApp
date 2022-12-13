//
//  HomeViewModel.swift
//  NumNum
//
//  Created by Ekrem Alkan on 5.12.2022.
//

import Foundation


class HomeViewModel {
    
    let manager = HomeManager.shared
    
    
    var allCategories = [Category]()
    var popularDishes = [Dishes]()
    var speacialDishes = [Dishes]()
    var categoryDishes = [Dish]()
    var errorCallback: ((String)->())?
    var successCallback: (()->())?
    
    
    //MARK: - Getting AllCategories
    
    func getCategory() {
        manager.getCategoryFoods(type: .fetchAllCategories) { foods in
            if let foods = foods {
                self.allCategories = foods.data?.categories ?? []
                self.successCallback?()
            }
            
        } onError: { error in
            print("Error while getting Category Data\(error)")
        }
        
    }
    
    func getPopularDishes() {
        manager.getCategoryFoods(type: .fetchAllCategories) { foods in
            if let foods = foods {
                self.popularDishes = foods.data?.populars ?? []
                self.successCallback?()
            }
        } onError: { error in
            print("Error while getting PopularDishes Data\(error)")
        }
        
    }
    
    func getSpecialDishes() {
        manager.getCategoryFoods(type: .fetchAllCategories) { foods in
            if let foods = foods {
                self.speacialDishes = foods.data?.specials ?? []
                self.successCallback?()
            }
        } onError: { error in
            print("Error while getting SpecialDishes Data\(error)")
        }
        
    }
    
    func getCategoryDishes(catID: String) {
        manager.getDetailDishes(type: .fetchCategoryDishes(catID)) { foods in
            if let foods = foods {
                self.categoryDishes = foods.data ?? []
                self.successCallback?()
            }
        } onError: { error in
            print("Error while getting CategoryDishes Data\(error)")
        }
        
    }
    
    
    
}



