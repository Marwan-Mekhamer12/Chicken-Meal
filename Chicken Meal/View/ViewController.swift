//
//  ViewController.swift
//  Chicken Meal
//
//  Created by Marwan Mekhamer on 23/07/2025.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = ViewModelLogic()
    let items: AllMeals? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        updateData()
        viewModel.fetchMeals()
        FavoriteBarButtonItem()
        
    }
    
    func updateData() {
        viewModel.didUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    func FavoriteBarButtonItem() {
        let bar = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .done, target: self, action: #selector(favorite))
        bar.tintColor = .red
        navigationItem.rightBarButtonItem = bar
    }
    
    @objc
    func favorite() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "fav") as? FavoriteMeal {
            vc.title = "Favorites"
            vc.tabBarItem.badgeColor = .systemOrange
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func LikeBtnAction(_ sender: UIButton) {
        // Like Button
         
        
    }
    


}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberofCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionViewCell
        let item = viewModel.IndexRow(at: indexPath.row)
        cell.setUpMeals(items: item)
        cell.layer.cornerRadius = 12
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.1
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.alpha = 0
        UIView.animate(withDuration: 0.3) {
            cell.alpha = 1
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let meal = viewModel.IndexRow(at: indexPath.row)
        if let vc = storyboard?.instantiateViewController(withIdentifier: "pressed") as? PressedMealVC {
            vc.modalPresentationStyle = .fullScreen
            vc.title = "Meal 🤤"
            vc.meal = meal
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 3, bottom: 1, right: 3)
    }
    
}
