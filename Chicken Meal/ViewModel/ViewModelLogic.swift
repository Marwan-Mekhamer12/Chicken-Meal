//
//  ViewModelLogic.swift
//  Chicken Meal
//
//  Created by Marwan Mekhamer on 23/07/2025.
//

import Foundation

protocol Logics {
    func IndexRow(at index: Int) -> AllMeals
    func fetchMeals()
    func searchMeals(with query: String)
    
    var numberOfFavorites: Int { get }
    func item(at index: Int) -> FavoriteItems
}

class ViewModelLogic: Logics {
    
    
    private var allMeals = [AllMeals]()        // All original meals from API
    private var filteredMeals = [AllMeals]()   // Filtered meals for search
    private var favouriteitem = [FavoriteItems]()
    private var isSearching = false            // Track if searching

    var didUpdate: (() -> Void)?
    
    // MARK: - Count based on search state
    var numberofCount: Int {
        return isSearching ? filteredMeals.count : allMeals.count
    }
    
   

    // MARK: - Get meal by index
    func IndexRow(at index: Int) -> AllMeals {
        return isSearching ? filteredMeals[index] : allMeals[index]
    }

    // MARK: - Fetch data from API
    func fetchMeals() {
        let fetch = FetchDataLogic()
        fetch.fetchData { [weak self] meals in
            DispatchQueue.main.async {
                self?.allMeals = meals
                self?.isSearching = false
                self?.didUpdate?()
            }
        }
    }

    // MARK: - Search logic
    func searchMeals(with query: String) {
        if query.isEmpty {
            isSearching = false
        } else {
            isSearching = true
            filteredMeals = allMeals.filter { $0.strMeal.lowercased().contains(query.lowercased()) }
        }
        didUpdate?()
    }
    
    var favorites: [FavoriteItems] {
        return Favorite.shared.fav
    }
    
    var numberOfFavorites: Int {
        return favorites.count
    }
    
    func item(at index: Int) -> FavoriteItems {
        return favorites[index]
    }

}

