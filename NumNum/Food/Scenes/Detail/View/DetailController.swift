//
//  DetailController.swift
//  NumNum
//
//  Created by Ekrem Alkan on 16.12.2022.
//

import UIKit
import Firebase
import SDWebImage
import PanModal


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
    
    //MARK: - StepperAction

    @IBAction func stepperTapped(_ sender: UIStepper) {
        quantityLabel.text = String(Int(stepper.value))
        switch stepper.value {
        case 0:
            database.child("Users").child(currentUser?.uid ?? "").child(items?.name ?? "").removeValue { error, data in
                if error != nil {
                    DuplicateFuncs.alertMessage(title: "Ürün sepetten kaldırılırken hata meydana geldi.", message: "", vc: self)
                } else {
                    DuplicateFuncs.alertMessage(title: "Ürün başarıyla sepetten kaldırıldı.", message: "", vc: self)
                    self.stepperFeatures()
                }
                self.configureAddBtn()
            }
        case 0...10:
            database.child("Users").child(currentUser?.uid ?? "").child(items?.name ?? "").updateChildValues(["quantity" : quantityLabel.text!])
        case 11..<100:
            stepper.value = 10
            self.quantityLabel.text = String(Int(stepper.value))
            DuplicateFuncs.alertMessage(title: "Bir üründen maksimum 10 adet sipariş verebilrisiniz.", message: "", vc: self)
        default:
            return
        }
        
        
        
    }
    
    //MARK: - AddButtonAction

    @IBAction func addBtnTapped(_ sender: UIButton) {
        configureAddBtn()
    }
    
    //MARK: - ConfigureUI

    private func isHiddenUI(bool: Bool) {
        quantityLabel.isHidden = bool
        stepper.isHidden = bool
    }
    
    //MARK: - StepperFeatures

    private func stepperFeatures() {
        stepper.value = 1
        quantityLabel.text = String(Int(stepper.value))
    }
    
    //MARK: - ConfigureAddButton

    private func configureAddBtn() {
        if isSelected {
            isSelected = false
            addBtn.setImage(UIImage(named: "Added"), for: .normal)
            createUsersData()
            showBasket()
            stepperFeatures()
            isHiddenUI(bool: isSelected)
            DuplicateFuncs.alertMessage(title: "Ürün sepete eklendi.", message: "", vc: self)
            
        } else {
            isSelected = true
            addBtn.setImage(UIImage(named: "Add"), for: .normal)
            isHiddenUI(bool: isSelected)
            database.child("Users").child(currentUser?.uid ?? "").child(items?.name ?? "").removeValue { error, data in
                if error != nil {
                    DuplicateFuncs.alertMessage(title: "Ürün sepetten kaldırılırken hata meydana geldi.", message: "", vc: self)
                } else {
                    DuplicateFuncs.alertMessage(title: "Ürün başarıyla sepetten kaldırıldı.", message: "", vc: self)
                }
            }
            stepperFeatures()
        }
        
    }
    
    //MARK: - ShowBasketController with PanModal

    private func showBasket() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "\(BasketController.self)") as! BasketController
        self.presentPanModal(controller)
        
        
        
    }
    
    //MARK: - CreateUsersData to Firebase

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
                database.child("Users").child(currentUser!.uid).child(items?.name ?? "").setValue(object)
                
            }
            
        }
        
    }
    
    //MARK: - Getting Data for Firebase

    func getDataForFirebase(data: Dish) {
        items = data
    }
    
    //MARK: - Configure IBOutlets

    func configure(data: DetailDishViewProtocol) {
        image.sd_setImage(with: URL(string: data.detailİmage))
        titleLabel.text = data.detailTitle
        calorieLabel.text = "~\(data.detailCalorie)kcal"
        descriptionLabel.text = data.detailDescription
    }
    
}



