//
//  CategoryViewCell.swift
//  NumNum
//
//  Created by Ekrem Alkan on 11.12.2022.
//

import UIKit
import SDWebImage

protocol CategoryViewCellProtocol {
    var categoryCellİmage: String { get }
    var catergoryCellLabel: String { get }
}
class CategoryViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var label: UILabel!
    
    func configure(data: CategoryViewCellProtocol) {
        label.text = data.catergoryCellLabel
        image.sd_setImage(with: URL(string: data.categoryCellİmage))
    }
    
}


