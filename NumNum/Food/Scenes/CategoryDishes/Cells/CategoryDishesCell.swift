//
//  CategoryDishesCell.swift
//  NumNum
//
//  Created by Ekrem Alkan on 23.12.2022.
//

import UIKit
import SDWebImage

protocol CategoryDishesCellProtocol {
    var categoryDishesImage: String { get }
    var categoryTitleLabel: String { get }
    var categoryCalorieLabel: String { get }
}

class CategoryDishesCell: UICollectionViewCell {

    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var calorieLabel: UILabel!
    @IBOutlet weak var categoryName: UILabel!
    
    func configure(data: CategoryDishesCellProtocol) {
        image.sd_setImage(with: URL(string: data.categoryDishesImage))
        titleLabel.text = data.categoryTitleLabel
        calorieLabel.text = "\(data.categoryCalorieLabel)kcal"
        
    }
}
