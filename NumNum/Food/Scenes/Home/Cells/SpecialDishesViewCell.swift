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
    var specialCalorie: String { get }
    var specialDescription: String { get }
}

class SpecialDishesViewCell: UICollectionViewCell {
    
    @IBOutlet  private weak var image: UIImageView!
    @IBOutlet  private weak var titleLabel: UILabel!
    @IBOutlet  private weak var calorieLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(data: SpecialDishesViewCellProtocol) {
        image.sd_setImage(with: URL(string: data.specialImage))
        image.layer.cornerRadius = 10
        titleLabel.text = data.specialTitle
        calorieLabel.text = "~\(data.specialCalorie)kcal"
        descriptionLabel.text = data.specialDescription
    }
    

    
    
    
  
    
}


