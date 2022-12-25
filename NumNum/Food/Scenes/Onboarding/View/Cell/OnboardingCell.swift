//
//  OnboardingCell.swift
//  NumNum
//
//  Created by Ekrem Alkan on 2.12.2022.
//

import UIKit



class OnboardingCell: UICollectionViewCell {
    
    @IBOutlet private weak var slideImageView: UIImageView!
    @IBOutlet private weak var slideTitleLabel: UILabel!
    @IBOutlet private weak var slideDescriptionLabel: UILabel!
    
    func configure(data: OnboardingSlide) {
        slideImageView.image = data.image
        slideTitleLabel.text = data.title
        slideDescriptionLabel.text = data.description
    }
}
