//
//  CategoryCollectionViewCell.swift
//  Chicken Meal
//
//  Created by Marwan Mekhamer on 27/07/2025.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ChickenImg: UIImageView!
    
    func setUp(items: AllMeals) {
        ChickenImg.image = nil
        ChickenImg.layer.cornerRadius = 18
        
        if let url = URL(string: items.strMealThumb) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                if let safeData = data, let image = UIImage(data: safeData){
                    DispatchQueue.main.async {
                        self?.ChickenImg.image = image
                    }
                }
            }
            .resume()
        }
    }
    
    
}
