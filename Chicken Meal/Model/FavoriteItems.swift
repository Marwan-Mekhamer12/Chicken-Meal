//
//  FavoriteItems.swift
//  Chicken Meal
//
//  Created by Marwan Mekhamer on 27/07/2025.
//

import Foundation
import UIKit

struct FavoriteItems {
    var img: String
    var name: String
    var category: String
    var area: String
}

class Favorite {
   static let shared = Favorite()
    init() {}
    
    var fav: [FavoriteItems] = []
}
