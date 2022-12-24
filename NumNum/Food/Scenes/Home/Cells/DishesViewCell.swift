//
//  DishesViewCell.swift
//  NumNum
//
//  Created by Ekrem Alkan on 13.12.2022.
//

import UIKit

protocol DishesViewCellProtocol {
    var dishesCellImage: String { get }
    var dishesCellTitle: String { get }
    var dishesCellCalorie: String { get }
}
class DishesViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var calorieLabel: UILabel!
    
    func configure(data: DishesViewCellProtocol) {
        image.sd_setImage(with: URL(string: data.dishesCellImage))
        titleLabel.text = data.dishesCellTitle
        calorieLabel.text = "\(data.dishesCellCalorie)kcal"
    }
}
