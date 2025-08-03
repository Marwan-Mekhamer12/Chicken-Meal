//
//  CategoryTableViewCell.swift
//  Chicken Meal
//
//  Created by Marwan Mekhamer on 27/07/2025.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var chickenImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    func setUp(_ item: AllMeals) {
        nameLabel.text = item.strMeal
        categoryLabel.text = item.strCategory
        areaLabel.text = item.strArea
        descLabel.text = item.strInstructions
        chickenImage.image = nil
        
        if let url = URL(string: item.strMealThumb) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                if let safeData = data, let image = UIImage(data: safeData) {
                    DispatchQueue.main.async {
                        self?.chickenImage.image = image
                    }
                }
            }
            .resume()
        }
    }
}
