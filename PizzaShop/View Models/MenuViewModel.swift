//
//  MenuViewModel.swift
//  PizzaShop
//
//  Created by Arman Abkar on 12/18/21.
//

import UIKit

final class MenuViewModel {
    
    var webService: API = WebService.shared
    var items: [[Food?]] = [[], [], [], []]
    let sectionHeaders = ["Pizzas", "Salads", "Desserts", "Beverages"]
    
    func getFoods(from vc: UIViewController, completion: @escaping () -> Void) {
        Task.init {
            do {
                let fetchedItems = try await webService.getAllFoods()
                fetchedItems.forEach { food in
                    switch food.type {
                        case "pizza":
                            items[0].append(food)
                        case "salad":
                            items[1].append(food)
                        case "dessert":
                            items[2].append(food)
                        case "beverage":
                            items[3].append(food)
                        default:
                            break
                    }
                }
                completion()
            } catch {
                await UIAlertController.showAlert(message: K.Alert.fetchingError, from: vc)
            }
        }
    }
    
}
