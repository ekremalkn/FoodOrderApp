//
//  HomeController.swift
//  NumNum
//
//  Created by Ekrem Alkan on 5.12.2022.
//

import UIKit

class HomeController: UIViewController {
    
    var homeViewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        homeViewModel.getCategory()
    }
    
}
