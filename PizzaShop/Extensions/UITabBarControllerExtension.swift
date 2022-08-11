//
//  UITabBarControllerExtension.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/11/22.
//

import UIKit

extension UITabBarController {
    static func updateCartTabBadge(tabItem: UITabBarItem, from: UIViewController) {
        CoreDataService.shared.loadCartItems { result in
            switch result {
                case .success(let cart):
                    if cart.count > 0 {
                        tabItem.badgeValue = "\(cart.count)"
                        tabItem.badgeColor = .gray
                    } else {
                        tabItem.badgeValue = nil
                    }
                case .failure(let error):
                    UIAlertController.showAlert(message: "Error updating badge: \(error.localizedDescription)",
                                                from: from)
            }
        }
    }
}
