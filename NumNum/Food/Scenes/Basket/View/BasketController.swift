//
//  BasketController.swift
//  NumNum
//
//  Created by Ekrem Alkan on 17.12.2022.
//

import UIKit
import Firebase
import SDWebImage

class BasketController: UIViewController {
    
    @IBOutlet private weak var collection: UICollectionView!
    
    let database = Database.database().reference()
    var dishes = [FirebaseDataModel]()
    
    var errorCallback: ((String)->())?
    var successCallback: (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionSetup()
        getDataFromFirebase()
        isSucceed()
        
        
    }
    
    
    private func collectionSetup() {
        collection.register(UINib(nibName: "\(SpecialDishesViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(SpecialDishesViewCell.self)")
    }
    private func isSucceed() {
        successCallback = { [ weak self ] in
            self?.collection.reloadData()
            
            
            
        }
    }
    
    
    private func getDataFromFirebase() {
        let uid = Auth.auth().currentUser?.uid
        
        database.child("Users").child(uid!).observeSingleEvent(of: .value) { (snapshot: DataSnapshot?) in
            if let data = snapshot?.children.allObjects as? [DataSnapshot] {
                self.dishes.removeAll()
                
                for snap in data {
                    
                    if let postDic = snap.value as? Dictionary<String, Any> {
                        
                        let name = postDic["name"]!
                        let image = postDic["image"]!
                        let description = postDic["popularDescription"]!
                        let calories = "\(postDic["calories"]!)"
                        self.dishes.append(FirebaseDataModel(name: name as? String, image: image as? String, calories: calories, description: description as? String))
                    }
                    
                }
                
                self.successCallback?()
            }
        }
        
        
        
        
    }
    
}





extension BasketController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "\(SpecialDishesViewCell.self)", for: indexPath) as! SpecialDishesViewCell
        cell.configureFirebaseData(data: dishes[indexPath.row])
        return cell
        
    }
    
    
}



