//
//  DetailController.swift
//  NumNum
//
//  Created by Ekrem Alkan on 16.12.2022.
//

import UIKit
import SDWebImage

protocol DetailDishViewProtocol {
    var detailİmage: String { get }
    var detailTitle: String { get }
    var detailCalorie: String { get }
    var detailDescription: String { get }
    
}

class DetailController: UIViewController {
    
    
    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var calorieLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func configure(data: DetailDishViewProtocol) {
        image.sd_setImage(with: URL(string: data.detailİmage))
        titleLabel.text = data.detailTitle
        calorieLabel.text = data.detailCalorie
        descriptionLabel.text = data.detailDescription
    }
    
}
