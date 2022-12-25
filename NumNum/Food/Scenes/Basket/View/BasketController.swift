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
    
    @IBOutlet weak var payView: UIView!
    @IBOutlet weak var checkoutButton: UIButton!
    
    
    var isSelected: Bool = true
    
    var basketViewModel = BasketViewModel()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidLoad()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionSetup()
        basketViewModel.getDataFromFirebase()
        isSucceed()
        configureUI()
        
    }
    
    //MARK: - ConfigureUI Buttons

    func configureUI() {
        payView.layer.cornerRadius = 25
        checkoutButton.layer.cornerRadius = 10
    }
    
    //MARK: - Button actions

    @IBAction func checkoutBtnTapped(_ sender: UIButton) {
        basketViewModel.updateFirebaseData()
        basketViewModel.getDataFromFirebase()
        isSucceed()
        if basketViewModel.dishes.count > 0 {
            DuplicateFuncs.alertMessage(title: "Your order has been taken!", message: "", vc: self)
        } else {
            DuplicateFuncs.alertMessage(title: "Your cart is empty.", message: "Please add items to your cart.", vc: self)
        }
    }
    
    //MARK: - Register UINib's
    
    private func collectionSetup() {
        collection.register(UINib(nibName: "\(BasketViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(BasketViewCell.self)")
    }
    
    //MARK: - ViewModelConfiguration
    
    private func isSucceed() {
        self.basketViewModel.successCallback = { [ weak self ] in
            self?.collection.reloadData()
            self?.cartTotalLabel.text = "\(self?.basketViewModel.totalCost ?? 0) Items"
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
        cell.layer.cornerRadius = 10
        cell.delegate = self
        return cell
        
        
    }
    
    
}

//MARK: - BasketViewCellSubclassDelegate

extension BasketController: BasketViewCellSubclassDelegate {
    func stepperValueDidChange(cell: BasketViewCell, stepper: UIStepper) {
        guard let indexPath = self.collection.indexPath(for: cell) else {
            return
        }
        
        if stepper.value == 0 {
            basketViewModel.getDataFromFirebase()
            isSucceed()
            basketViewModel.dishes.remove(at: indexPath.row)
            collection.deleteItems(at: [indexPath])
            
        } else {
            basketViewModel.getDataFromFirebase()
            isSucceed()
            
        }
        
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



