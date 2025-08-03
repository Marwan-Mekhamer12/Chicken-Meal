//
//  FavoriteMeal.swift
//  Chicken Meal
//
//  Created by Marwan Mekhamer on 23/07/2025.
//

import UIKit

class FavoriteMeal: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewmodel: ViewModelLogic!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        viewmodel = ViewModelLogic()
        tableView.delegate = self
        tableView.dataSource = self
        deleteBarButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData() 
    }
    
    func deleteBarButtonItem() {
        let bar = UIBarButtonItem(image: UIImage(systemName: "trash"),
                                  style: .done,
                                  target: self,
                                  action: #selector(deledeMethon))
        
        navigationItem.rightBarButtonItem = bar
    }
    
    @objc
    func deledeMethon() {
        tableView.isEditing = !tableView.isEditing
    }
    
}


extension FavoriteMeal: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel.numberOfFavorites
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favcell", for: indexPath) as! FavTableViewCell
        let item = viewmodel.item(at: indexPath.row)
        cell.setUp(item)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "") { [weak self] _, _, completionHandler in
            guard let self = self else { return }
            
            // Remove from Favorite.shared.fav
            let deletedItem = self.viewmodel.item(at: indexPath.row)
            if let index = Favorite.shared.fav.firstIndex(where: { $0.name == deletedItem.name }) {
                Favorite.shared.fav.remove(at: index)
            }
            
            // Reload ViewModel if needed
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
            
            completionHandler(true)
        }
        
        delete.backgroundColor = .red
        delete.image = UIImage(systemName: "trash") // ✅ Set icon
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
