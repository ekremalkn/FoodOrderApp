//
//  HomeController.swift
//  NumNum
//
//  Created by Ekrem Alkan on 5.12.2022.
//

import UIKit

class HomeController: UIViewController {
    
    @IBOutlet weak var topCollection: UICollectionView!
    @IBOutlet weak var midCollection: UICollectionView!
    @IBOutlet weak var bottomCollection: UICollectionView!
    var homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionSetup()
        getData()
        isSucceed()
    }
    
    //MARK: - CollectionCells Setup
    
    private func collectionSetup() {
        topCollection.register(UINib(nibName: "\(CategoryViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(CategoryViewCell.self)")
        midCollection.register(UINib(nibName: "\(DishesViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(DishesViewCell.self)")
        bottomCollection.register(UINib(nibName: "\(SpecialDishesViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(SpecialDishesViewCell.self)")
    }
    
    //MARK: - Getting Data
    
    private func getData() {
        homeViewModel.getCategory()
        homeViewModel.getPopularDishes()
        homeViewModel.getSpecialDishes()
    }
    
    //MARK: - Checking data received
    
    private func isSucceed() {
        homeViewModel.successCallback = { [weak self] in
            self?.topCollection.reloadData()
            self?.midCollection.reloadData()
            self?.bottomCollection.reloadData()
        }
        
        
    }
    
}

//MARK: - CollectionView Methods

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case topCollection:
            return homeViewModel.allCategories.count
        case midCollection:
            return homeViewModel.popularDishes.count
        case bottomCollection:
            return homeViewModel.speacialDishes.count
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case topCollection:
            let cell = topCollection.dequeueReusableCell(withReuseIdentifier: "\(CategoryViewCell.self)", for: indexPath) as! CategoryViewCell
            cell.layer.cornerRadius = 10
            cell.configure(data: homeViewModel.allCategories[indexPath.row])
            return cell
        case midCollection:
            let cell = midCollection.dequeueReusableCell(withReuseIdentifier: "\(DishesViewCell.self)", for: indexPath) as! DishesViewCell
            cell.layer.cornerRadius = 10
            cell.configure(data: homeViewModel.popularDishes[indexPath.row])
            return cell
        case bottomCollection:
            let cell = bottomCollection.dequeueReusableCell(withReuseIdentifier: "\(SpecialDishesViewCell.self)", for: indexPath) as! SpecialDishesViewCell
            cell.layer.cornerRadius  = 10
            cell.configure(data: homeViewModel.speacialDishes[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let catID =  homeViewModel.allCategories[indexPath.row].id ?? ""
        homeViewModel.getCategoryDishes(catID: catID)
        
    }
    
    
}
