//
//  Alerts.swift
//  Chicken Meal
//
//  Created by Marwan Mekhamer on 23/07/2025.
//

import Foundation
import UIKit

protocol AlertsController {
    func Alerty(handler: @escaping () -> Void) -> UIAlertController
}

class Alerts: AlertsController {
    
    func Alerty(handler: @escaping () -> Void) -> UIAlertController {
        let alert = UIAlertController(title: "Open Youtube Link?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Open", style: .default, handler: { _ in
            handler()
        }))
        
        return alert
    }
    
    
    
    
    
    
    
}
