//
//  SpecialDishesViewCell.swift
//  NumNum
//
//  Created by Ekrem Alkan on 13.12.2022.
//

import UIKit

protocol SpecialDishesViewCellProtocol {
    var specialImage: String { get }
    var specialTitle: String { get }
    var specialDescription: String { get }
    var specialCalorie: String { get }
}

class SpecialDishesViewCell: UICollectionViewCell {
    
    @IBOutlet  weak var image: UIImageView!
    @IBOutlet  weak var titleLabel: UILabel!
    @IBOutlet  weak var descriptionLabel: UILabel!
    @IBOutlet  weak var calorieLabel: UILabel!
    

    func configure(data: SpecialDishesViewCellProtocol) {
        image.sd_setImage(with: URL(string: data.specialImage))
        titleLabel.text = data.specialTitle
        descriptionLabel.text = data.specialDescription
        calorieLabel.text = data.specialCalorie
    }
    
    
    func configureFirebaseData(data: FirebaseDataModel) {
        image.sd_setImage(with: URL(string: data.image ?? ""))
        titleLabel.text = data.name
        descriptionLabel.text = data.description
        calorieLabel.text = data.calories
    }
    
    
    
  
    
}


