//
//  OnboardingViewController.swift
//  NumNum
//
//  Created by Ekrem Alkan on 2.12.2022.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet private weak var collection: UICollectionView!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var pageControl: UIPageControl!
    
    @IBOutlet private weak var skipButton: UIButton!
    
    private var slides: [OnboardingSlide] = []
    
    private var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                skipButton.isHidden = true
                nextButton.setTitle("Get Started", for: .normal)
            } else {
                skipButton.isHidden = false
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setSlides()
    }
    
    
    //MARK: - UIView
    
    private func setSlides() {
        slides = [OnboardingSlide(title: "Order your favourites", description: " ", image: #imageLiteral(resourceName: "onboarding1")),
                  OnboardingSlide(title: "Get delivered to you within the shortest time", description: "", image: #imageLiteral(resourceName: "onboarding2"))
        ]
    }
    
    private func setView() {
        nextButton.layer.cornerRadius = 10
    }
    
    
    //MARK: - Show LogInScreen
    
    private func showLogInScreen() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "LogInController") as! LogInController
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
    //MARK: - ActionButtons
    
    @IBAction func skipButton(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "LogInController") as! LogInController
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
    
    @IBAction func nextButtonCliccked(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            showLogInScreen()
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
        }
        
    }
    
}

//MARK: - CollectionView Methods

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as! OnboardingCell
        cell.configure(data: slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        
    }
    
    
}
