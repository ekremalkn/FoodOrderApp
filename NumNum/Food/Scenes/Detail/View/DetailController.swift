//
//  DetailController.swift
//  NumNum
//
//  Created by Ekrem Alkan on 16.12.2022.
//

import UIKit
import Firebase
import FirebaseDatabase
import SDWebImage


protocol DetailDishViewProtocol {
    var detailİmage: String { get }
    var detailTitle: String { get }
    var detailCalorie: String { get }
    var detailDescription: String { get }
    
}

class DetailController: UIViewController {
    
    private let database = Database.database().reference()
    
    
    
    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var calorieLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    var items: Dish?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addBtnTapped(_ sender: Any) {
        let currentUser = Auth.auth().currentUser
        
        if currentUser == nil {
            DuplicateFuncs.alertMessage(title: "Giriş yapmadınız!", message: "Sepete eklemeden önce giriş yapınız.", vc: self)
        } else {
            if items != nil {
                var description: String?
                
                if items?.popularDescription != nil {
                    description = items?.popularDescription
                } else if items?.datumDescription != nil {
                    description = items?.datumDescription
                }
                
                let object: [String : Any] = [
                    "id": items?.id ?? "",
                    "name": items?.name ?? "",
                    "description": description ?? "",
                    "image": items?.image ?? "",
                    "calories": items?.calories ?? ""
                ]
                database.child("Users").child(currentUser!.uid).childByAutoId().setValue(object)
            }
            
            
        }
        
        
        
    }
    
    func getDataForFirebase(data: Dish) {
        items = data
    }
    
    func configure(data: DetailDishViewProtocol) {
        image.sd_setImage(with: URL(string: data.detailİmage))
        titleLabel.text = data.detailTitle
        calorieLabel.text = data.detailCalorie
        descriptionLabel.text = data.detailDescription
    }
    
}
