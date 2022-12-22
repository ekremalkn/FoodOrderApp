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
    private let currentUser = Auth.auth().currentUser
    
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var stepper: UIStepper!
    
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var calorieLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var items: Dish?
    var isSelected: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
            }
    
    @IBAction func quantityItem(_ sender: UIStepper) {
        quantityLabel.text = String(Int(sender.value + 1))
        if quantityLabel.text == String(0) {
            quantityLabel.isHidden = true
        } else if Int(sender.value) > 9 {
            quantityLabel.text = String(10)
            DuplicateFuncs.alertMessage(title: "Bir üründen maksimum 10 adet sipariş verebilrisiniz.", message: "", vc: self)
        }
        createUsersData()
        
    }
    @IBAction func addBtnTapped(_ sender: UIButton) {
        configureAddBtn()
    }
    
    private func configureAddBtn() {
        if isSelected {
            isSelected = false
            addBtn.setImage(UIImage(named: "Added"), for: .normal)
            createUsersData()
            DuplicateFuncs.alertMessage(title: "Ürün sepete eklendi.", message: "", vc: self)
            
        } else {
            isSelected = true
            addBtn.setImage(UIImage(named: "Add"), for: .normal)
            database.child("Users").child(currentUser!.uid).child("\(items?.name)").removeValue()
            DuplicateFuncs.alertMessage(title: "Urün sepetten kaldırıldı.", message: "", vc: self)
        }
        
    }
    
    private func createUsersData() {
        
        
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
                    "quantity": quantityLabel.text ?? "",
                    "id": items?.id ?? "",
                    "name": items?.name ?? "",
                    "description": description ?? "",
                    "image": items?.image ?? "",
                    "calories": items?.calories ?? ""
                ]
                database.child("Users").child(currentUser!.uid).child("\(items?.name)").setValue(object)
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
