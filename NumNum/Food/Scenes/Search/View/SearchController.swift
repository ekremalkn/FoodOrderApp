//
//  SearchController.swift
//  NumNum
//
//  Created by Ekrem Alkan on 20.12.2022.
//

import UIKit

class SearchController: UIViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    
    @IBOutlet private  weak var topCollection: UICollectionView!
    
    private var searchViewModel = SearchViewModel()
    
    var segmentedDishes = [Dish]()
    var allCategoryDishes = [Dish]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionSetup()
        getData()
        isSucceed()
    }
    
    @IBAction func didChangeCategory(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            searchViewModel.getSearchDishes(catID: searchViewModel.searchCategories[sender.selectedSegmentIndex].id!)
            isSucceed()
        case 1:
            searchViewModel.getSearchDishes(catID: searchViewModel.searchCategories[sender.selectedSegmentIndex].id!)
            isSucceed()
        case 2:
            searchViewModel.getSearchDishes(catID: searchViewModel.searchCategories[sender.selectedSegmentIndex].id!)
            isSucceed()
        case 3:
            searchViewModel.getSearchDishes(catID: searchViewModel.searchCategories[sender.selectedSegmentIndex].id!)
            isSucceed()
        case 4:
            searchViewModel.getSearchDishes(catID: searchViewModel.searchCategories[sender.selectedSegmentIndex].id!)
            isSucceed()
        default:
            return
        }
    }
    
    
    private func collectionSetup() {
        topCollection.register(UINib(nibName: "\(SpecialDishesViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(SpecialDishesViewCell.self)")
    }
    
    private func getData() {
        searchViewModel.getSearchCategory()
        searchViewModel.getSearchDishes(catID: "cat1")
    }
    
    private func isSucceed() {
        searchViewModel.successCallback = { [ weak self ] in
            self?.segmentedDishes = self?.searchViewModel.searchDishes ?? []
            self?.topCollection.reloadData()
        }
    }
    
}

extension SearchController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            searchViewModel.searchDishes = segmentedDishes
            topCollection.reloadData()
        } else {
            searchViewModel.searchDishes = segmentedDishes.filter { Dish in
                Dish.name!.lowercased().contains(searchText.lowercased())
            }
            topCollection.reloadData()
        }
        
        
        
        
        
            
            
        
            
        
    }
}


extension SearchController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchViewModel.searchDishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = topCollection.dequeueReusableCell(withReuseIdentifier: "\(SpecialDishesViewCell.self)", for: indexPath) as! SpecialDishesViewCell
        cell.configure(data: searchViewModel.searchDishes[indexPath.row])
        return cell
    }
    
    
}
