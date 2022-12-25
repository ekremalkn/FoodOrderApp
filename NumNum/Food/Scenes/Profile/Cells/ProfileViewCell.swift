//
//  ProfileViewCell.swift
//  NumNum
//
//  Created by Ekrem Alkan on 25.12.2022.
//

import UIKit

class ProfileViewCell: UITableViewCell {
    
    @IBOutlet private weak var emailLabel: UILabel!
    
    func configure(data: String) {
        emailLabel.text = data
    }
}
