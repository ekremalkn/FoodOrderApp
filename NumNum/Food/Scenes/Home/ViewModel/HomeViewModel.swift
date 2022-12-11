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
    var errorCallback: ((String)->())?
    var successCallback: (()->())?
    
    
    //MARK: - Getting AllCategories
    
    func getCategory() {
        manager.getCategoryFoods(type: .fetchAllCategories) { foods in
            if let foods = foods {
                self.allCategories = foods.data!.categories ?? []
                self.successCallback?()
            }

        } onError: { error in
            print("Error while getting Category Data\(error)")
        }

    }
    
    
   
}



