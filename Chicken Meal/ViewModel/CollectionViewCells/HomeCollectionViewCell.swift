//
//  HomeCollectionViewCell.swift
//  Chicken Meal
//
//  Created by Marwan Mekhamer on 23/07/2025.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageMeal: UIImageView!
    @IBOutlet weak var nameMealLabel: UILabel!
    
    func setUpMeals(items: AllMeals) {
        
        nameMealLabel.text = items.strMeal
        imageMeal.image = nil
        
        imageMeal.layer.cornerRadius = 12
        
        if let url = URL(string: items.strMealThumb) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                if let error = error {
                    print("❌ Error to load image: \(error)")
                }
                if let URLimage = data, let image = UIImage(data: URLimage) {
                    DispatchQueue.main.async {
                        self?.imageMeal.image = image
                    }
                }
            }
            .resume()
        }
    }
    
}
