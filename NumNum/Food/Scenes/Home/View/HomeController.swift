//
//  HomeController.swift
//  NumNum
//
//  Created by Ekrem Alkan on 5.12.2022.
//

import UIKit

class HomeController: UIViewController {
    
    @IBOutlet weak var topCollection: UICollectionView!
    var homeViewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionSetup()
        homeViewModel.getCategory()
        homeViewModel.successCallback = { [weak self] in
            self?.topCollection.reloadData()
            
        }
    }
    
    private func collectionSetup() {
        topCollection.register(UINib(nibName: "\(CategoryViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(CategoryViewCell.self)")
    }
    
}


extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("\(homeViewModel.allCategories.count)alkan")
        return homeViewModel.allCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = topCollection.dequeueReusableCell(withReuseIdentifier: "\(CategoryViewCell.self)", for: indexPath) as! CategoryViewCell
        cell.layer.cornerRadius = 10
        cell.configure(data: homeViewModel.allCategories[indexPath.row])
        return cell
    }
    
    
}
