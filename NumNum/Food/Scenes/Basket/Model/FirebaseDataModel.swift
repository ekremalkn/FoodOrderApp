//
//  FirebaseDataModel.swift
//  NumNum
//
//  Created by Ekrem Alkan on 18.12.2022.
//

import Foundation


struct FirebaseDataModel: BasketViewCellProtocol {
    
    let name: String?
    let image: String?
    let calories: String?
    let description: String?
    let quantity: String?
    
    //MARK: - BasketViewCellProtocol
    var basketQuantityLabel: String {
        quantity ?? ""
    }
    
    var basketTitleLabel: String {
        name ?? ""
    }
    
    var basketImage: String {
        image ?? ""
    }
    
}
