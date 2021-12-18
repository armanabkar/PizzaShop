//
//  MenuViewModel.swift
//  PizzaShop
//
//  Created by Arman Abkar on 12/18/21.
//

import UIKit
import Combine

final class MenuViewModel {
    
    var webService: API = WebService.shared
    var items: [Food?] = []
    
    func getAllFoods(from vc: UIViewController, completion: @escaping () -> Void) {
        webService.getAllFoods { [weak self] result in
            switch result {
                case .success(let fetchedFoods):
                    if let fetchedFoods = fetchedFoods {
                        self?.items.append(contentsOf: fetchedFoods)
                        completion()
                    }
                case .failure(let error):
                    UIAlertController.showAlert(message: error.localizedDescription, from: vc)
            }
        }
    }
    
}
