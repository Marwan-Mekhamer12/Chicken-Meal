//
//  FavTableViewCell.swift
//  Chicken Meal
//
//  Created by Marwan Mekhamer on 28/07/2025.
//

import UIKit

class FavTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    
    
    
    func setUp(_ items: FavoriteItems) {
        
        nameLabel.text = items.name
        categoryLabel.text = items.category
        areaLabel.text = items.area
        photoImg.layer.cornerRadius = 12
        photoImg.image = nil
        
        if let url = URL(string: items.img) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                if let safeData = data, let image = UIImage(data: safeData) {
                    DispatchQueue.main.async {
                        self?.photoImg.image = image
                    }
                }
            }
            .resume()
        }
    }
}
