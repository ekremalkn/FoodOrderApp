//
//  BasketViewCell.swift
//  NumNum
//
//  Created by Ekrem Alkan on 23.12.2022.
//

import UIKit
import SDWebImage
import Firebase


protocol BasketViewCellProtocol {
    var basketQuantityLabel: String { get }
    var basketTitleLabel: String { get }
    var basketImage: String { get }
}

protocol BasketViewCellSubclassDelegate: AnyObject {
    func stepperValuDidChange(cell: BasketViewCell)
}

class BasketViewCell: UICollectionViewCell {
    
    
    var dataFirebase: FirebaseDataModel?
    
    var database = Database.database().reference()
    var currentUser = Auth.auth().currentUser
    
    
    var stepperValueChanged: Bool = true
    
    
    
    @IBOutlet private weak var stepper: UIStepper!
    
    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var quantityLabel: UILabel!
    
    weak var delegate: BasketViewCellSubclassDelegate?
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.delegate = nil
    }
    
    @IBAction func stepperTapped(_ sender: UIStepper) {
        
        quantityLabel.text = String(Int(stepper.value))
        
        switch stepper.value {
        case 0:
            database.child("Users").child(currentUser?.uid ?? "").child(dataFirebase?.name ?? "").removeValue()
            self.delegate?.stepperValuDidChange(cell: self)
        case 0...10:
            database.child("Users").child(currentUser?.uid ?? "").child(dataFirebase?.name ?? "").updateChildValues(["quantity" : quantityLabel.text!])
        case 11..<11111:
            stepper.value = 10
            self.quantityLabel.text = String(Int(stepper.value))
        default:
            return
        }
        
        
     
        
    }
    
 
    
    
    
    func getDataFromFirebase(data: FirebaseDataModel) {
        dataFirebase = data
    }
    
    func configure(data: BasketViewCellProtocol) {
        image.sd_setImage(with: URL(string: data.basketImage))
        image.layer.cornerRadius = 10
        titleLabel.text = data.basketTitleLabel
        quantityLabel.text = data.basketQuantityLabel
        stepper.value = Double(quantityLabel.text ?? "")!
    }
    
}
