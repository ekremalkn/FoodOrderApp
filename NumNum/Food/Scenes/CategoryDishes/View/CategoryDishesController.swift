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
    var categoryName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionSetup()
    }
    
    private func collectionSetup() {
        collection.register(UINib(nibName: "\(CategoryDishesCell.self)", bundle: nil), forCellWithReuseIdentifier:"\(CategoryDishesCell.self)")
    }
    
    func configure(data: [Dish]) {
        dishArray = data
    }
    
}

//MARK: - CollectionViewMethods

extension CategoryDishesController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dishArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "\(CategoryDishesCell.self)", for: indexPath) as! CategoryDishesCell
        cell.categoryName.text = categoryName
        cell.configure(data: dishArray[indexPath.row])
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = DetailController()
        let bundle = Bundle(for: type(of: controller))
        bundle.loadNibNamed("DetailController", owner: controller, options: nil)
        self.navigationController?.show(controller, sender: nil)
        controller.getDataForFirebase(data: dishArray[indexPath.row] )
        controller.configure(data: dishArray[indexPath.row])
    }
  
}

