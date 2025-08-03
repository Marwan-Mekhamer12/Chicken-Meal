//
//  CategoryVC.swift
//  Chicken Meal
//
//  Created by Marwan Mekhamer on 27/07/2025.
//

import UIKit

class CategoryVC: UIViewController {
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    let viewmodel = ViewModelLogic()
    
    let searchController = UISearchController(searchResultsController: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        searchBarC()
        update()
        viewmodel.fetchMeals()
    }
    
    
    func update() {
        viewmodel.didUpdate = { [weak self]  in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.tableView.reloadData()
            }
        }
    }
    
    
    func searchBarC() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Meals"
        definesPresentationContext = true

    }
    


}

// Mark: - CollectionView

extension CategoryVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewmodel.numberofCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categorycell", for: indexPath) as! CategoryCollectionViewCell
        let item = viewmodel.IndexRow(at: indexPath.row)
        cell.setUp(items: item)
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
}


// Mark: - TableView

extension CategoryVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel.numberofCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tablecategorycell", for: indexPath) as! CategoryTableViewCell
        let item = viewmodel.IndexRow(at: indexPath.row)
        cell.setUp(item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let meal = viewmodel.IndexRow(at: indexPath.row)
        if let vc = storyboard?.instantiateViewController(withIdentifier: "pressed") as? PressedMealVC {
            vc.modalPresentationStyle = .fullScreen
            vc.title = "Meal 🤤"
            vc.meal = meal
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}


extension CategoryVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text ?? ""
        viewmodel.searchMeals(with: query)
    }
    
    
}
