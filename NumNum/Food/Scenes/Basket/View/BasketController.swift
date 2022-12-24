//
//  BasketController.swift
//  NumNum
//
//  Created by Ekrem Alkan on 17.12.2022.
//

import UIKit
import PanModal

class BasketController: UIViewController {
    
    @IBOutlet  weak var collection: UICollectionView!
    @IBOutlet weak var cartTotalLabel: UILabel!
    
    var basketViewModel = BasketViewModel()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionSetup()
        basketViewModel.getDataFromFirebase()
        isSucceed()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func checkoutBtnTapped(_ sender: UIButton) {
        
    }
    
    //MARK: - Register UINib's

    private func collectionSetup() {
        collection.register(UINib(nibName: "\(BasketViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(BasketViewCell.self)")
    }
    
    //MARK: - ViewModelConfiguration

    private func isSucceed() {
        self.basketViewModel.successCallback = { [ weak self ] in
            self?.collection.reloadData()
        }
       
    }
    
}

//MARK: - CollectionViewMethods

extension BasketController: UICollectionViewDataSource, UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return basketViewModel.dishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "\(BasketViewCell.self)", for: indexPath) as! BasketViewCell
        cell.getDataFromFirebase(data: basketViewModel.dishes[indexPath.row])
        cell.configure(data: basketViewModel.dishes[indexPath.row])
        cell.delegate = self
        return cell
        
    }


}

//MARK: - BasketViewCellSubclassDelegate

extension BasketController: BasketViewCellSubclassDelegate {
    func stepperValuDidChange(cell: BasketViewCell) {
        guard let indexPath = self.collection.indexPath(for: cell) else {
            return
        }
        basketViewModel.dishes.remove(at: indexPath.row)
        collection.deleteItems(at: [indexPath])
    }
}

//MARK: - BasketController Presentation Style

extension BasketController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(530)
    }
    
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(300)
    }
    
    
}



