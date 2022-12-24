//
//  BasketViewModel.swift
//  NumNum
//
//  Created by Ekrem Alkan on 24.12.2022.
//

import Foundation
import Firebase


class BasketViewModel {
    
    var errorCallback: ((String)->())?
    var successCallback: (()->())?
    
    let database = Database.database().reference()
    let currentUser = Auth.auth().currentUser
    var dishes = [FirebaseDataModel]()
    
    
    func getDataFromFirebase() {
       let uid = Auth.auth().currentUser?.uid
       
       database.child("Users").child(uid!).observeSingleEvent(of: .value) { (snapshot: DataSnapshot?) in
           if let data = snapshot?.children.allObjects as? [DataSnapshot] {
               self.dishes.removeAll()
               
               for snap in data {
                   
                   if let postDic = snap.value as? Dictionary<String, Any> {
                       
                       let name = postDic["name"]!
                       let image = postDic["image"]!
                       let description = postDic["description"]!
                       let calories = "\(postDic["calories"]!)"
                       let quantity = postDic["quantity"]
                       self.dishes.append(FirebaseDataModel(name: name as? String, image: image as? String, calories: calories, description: description as? String, quantity: quantity as? String))
                   }
                   
               }
               
               self.successCallback?()
           }
       }
   }
}
