//
//  HomeController.swift
//  NumNum
//
//  Created by Ekrem Alkan on 5.12.2022.
//

import UIKit

class HomeController: UIViewController {
    
    @IBOutlet private weak var topCollection: UICollectionView!
    @IBOutlet private weak var midCollection: UICollectionView!
    @IBOutlet private weak var bottomCollection: UICollectionView!
    private var homeViewModel = HomeViewModel()

    override func viewDidLoad() {
        collectionSetup()
        getData()
        isSucceed()
    }
    
    @IBAction func basketBtnTapped(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "BasketController") as! BasketController
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    @IBAction func profileBtnTapped(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
        navigationController?.pushViewController(controller, animated: true)
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

//MARK: - CollectionViewMethods

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
        switch collectionView {
        case topCollection:
            let catID =  homeViewModel.allCategories[indexPath.row].id ?? ""
            homeViewModel.getCategoryDishes(catID: catID)
            homeViewModel.successCallback = { [ weak self ] in
                let controller = self?.storyboard?.instantiateViewController(withIdentifier: "CategoryDishesController") as! CategoryDishesController
                controller.categoryName = self?.homeViewModel.allCategories[indexPath.row].title
                controller.configure(data: (self?.homeViewModel.categoryDishes)!)
                self?.navigationController?.pushViewController(controller, animated: true)
            }
        case midCollection:
            let controller = DetailController()
            let bundle = Bundle(for: type(of: controller))
            bundle.loadNibNamed("DetailController", owner: controller, options: nil)
            self.navigationController?.show(controller, sender: nil)
            controller.getDataForFirebase(data: homeViewModel.popularDishes[indexPath.row])
            controller.configure(data: homeViewModel.popularDishes[indexPath.row])
        case bottomCollection:
            let controller = DetailController()
            let bundle = Bundle(for: type(of: controller))
            bundle.loadNibNamed("DetailController", owner: controller, options: nil)
            self.navigationController?.show(controller, sender: nil)
            controller.getDataForFirebase(data: homeViewModel.speacialDishes[indexPath.row])
            controller.configure(data: homeViewModel.speacialDishes[indexPath.row])
        default:
            return print("Did not show next VC")
        }
        
        
    }
    
    
}
