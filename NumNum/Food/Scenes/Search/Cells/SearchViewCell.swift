//
//  SearchViewCell.swift
//  NumNum
//
//  Created by Ekrem Alkan on 23.12.2022.
//

import UIKit
import SDWebImage
import Firebase


protocol SearchViewCellProtocol {
    var searchCellImage: String { get }
    var searchTitleLabel: String { get }
    var searchCalorieLabel: String { get }
    var searchDescriptionLabel: String { get }
}
class SearchViewCell: UICollectionViewCell {
    
    private let database = Database.database().reference()
    private let currentUser = Auth.auth().currentUser
    
    var items: Dish?
    
    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var calorieLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    func configure(data: SearchViewCellProtocol) {
        image.sd_setImage(with: URL(string: data.searchCellImage))
        image.layer.cornerRadius = 10
        titleLabel.text = data.searchTitleLabel
        descriptionLabel.text = data.searchDescriptionLabel
        calorieLabel.text = "~\(data.searchCalorieLabel)kcal"
    }
}
