//
//  PressedMealVC.swift
//  Chicken Meal
//
//  Created by Marwan Mekhamer on 23/07/2025.
//

import UIKit

class PressedMealVC: UIViewController {
    
    @IBOutlet weak var chickenImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var youtubeLink: UIButton!
    @IBOutlet weak var strIngredient1: UILabel!
    @IBOutlet weak var strIngredient2: UILabel!
    @IBOutlet weak var strIngredient3: UILabel!
    @IBOutlet weak var strIngredient4: UILabel!
    @IBOutlet weak var strIngredient5: UILabel!
    @IBOutlet weak var strIngredient6: UILabel!
    @IBOutlet weak var strIngredient7: UILabel!
    @IBOutlet weak var strIngredient8: UILabel!
    @IBOutlet weak var strIngredient9: UILabel!
    @IBOutlet weak var strIngredient10: UILabel!
    @IBOutlet weak var strIngredient11: UILabel!
    @IBOutlet weak var strIngredient12: UILabel!
    @IBOutlet weak var strIngredient13: UILabel!
    @IBOutlet weak var strIngredient14: UILabel!
    @IBOutlet weak var strIngredient15: UILabel!
    @IBOutlet weak var strIngredient16: UILabel!
    @IBOutlet weak var strIngredient17: UILabel!
    @IBOutlet weak var strIngredient18: UILabel!
    @IBOutlet weak var strIngredient19: UILabel!
    @IBOutlet weak var strIngredient20: UILabel!
    
    var meal: AllMeals?
    var alert = Alerts()
    
    var isLiked = false
    var likeButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        shows()
        favBarButton()
        chickenImage.layer.cornerRadius = 12
        youtubeLink.setTitle("▶️ Watch on YouTube", for: .normal)
        youtubeLink.backgroundColor = .systemRed
        youtubeLink.tintColor = .white
        youtubeLink.layer.cornerRadius = 10
    }
    
    func favBarButton() {
        likeButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .done, target: self, action: #selector(fav))
        likeButton.tintColor = .red
        navigationItem.rightBarButtonItem = likeButton
    }
    
    @objc
    func fav() {
        isLiked.toggle()
        let icon = isLiked ? "heart.fill" : "heart"
        likeButton.image = UIImage(systemName: icon)
        likeButton.tintColor = .red
        
        if isLiked {
            let liked = FavoriteItems(img: meal?.strMealThumb ?? "",
                                      name: meal?.strMeal ?? "",
                                      category: meal?.strCategory ?? "", area: meal?.strArea ?? "")
            Favorite.shared.fav.append(liked)
        } else {
            // Optional: remove if unliked
            if let index = Favorite.shared.fav.firstIndex(where: { $0.name == meal?.strMeal }) {
                Favorite.shared.fav.remove(at: index)
            }
        }
    }
    
    func shows() {
        guard let meal = meal else { return }

        nameLabel.text = meal.strMeal
        categoryLabel.text = meal.strCategory
        areaLabel.text = meal.strArea
        desLabel.text = meal.strInstructions
        youtubeLink.setTitle(meal.strYoutube, for: .normal)

        // Load image from URL
        if let url = URL(string: meal.strMealThumb) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        self?.chickenImage.image = UIImage(data: data)
                    }
                }
            }.resume()
        }

        // Ingredients
        let ingredients = [
            meal.strIngredient1, meal.strIngredient2, meal.strIngredient3, meal.strIngredient4, meal.strIngredient5,
            meal.strIngredient6, meal.strIngredient7, meal.strIngredient8, meal.strIngredient9, meal.strIngredient10,
            meal.strIngredient11, meal.strIngredient12, meal.strIngredient13, meal.strIngredient14, meal.strIngredient15,
            meal.strIngredient16, meal.strIngredient17, meal.strIngredient18, meal.strIngredient19, meal.strIngredient20
        ]
        
        let labels = [
            strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5,
            strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10,
            strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15,
            strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        ]
        
        for (index, ingredient) in ingredients.enumerated() {
            labels[index]?.text = ingredient
        }
    }

    @IBAction func YoutubeLinky(_ sender: UIButton) {
        if let urlString = meal?.strYoutube, let url = URL(string: urlString) {
            
            let alertyyy = alert.Alerty {
                UIApplication.shared.open(url)
            }
            present(alertyyy, animated: true)
        }
    }
    
   
    
}
