//
//  CategoryDishesController.swift
//  NumNum
//
//  Created by Ekrem Alkan on 16.12.2022.
//

import UIKit

class CategoryDishesController: UIViewController {
    
    @IBOutlet private weak var collection: UICollectionView!
    private var dishArray = [Dish]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionSetup()
    }
    
    private func collectionSetup() {
        collection.register(UINib(nibName: "\(DishesViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(DishesViewCell.self)")
    }
    
    func configure(data: [Dish]) {
        dishArray = data
    }
    
    
}

extension CategoryDishesController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dishArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "\(DishesViewCell.self)", for: indexPath) as! DishesViewCell
        cell.configure(data: dishArray[indexPath.row])
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = DetailController()
        let bundle = Bundle(for: type(of: controller))
        bundle.loadNibNamed("DetailController", owner: controller, options: nil)
        self.navigationController?.show(controller, sender: nil)
        controller.configure(data: dishArray[indexPath.row])
    }
    
    
    
    
    
    
}

