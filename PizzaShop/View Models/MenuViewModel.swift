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
    
    func getFoods(from vc: UIViewController, completion: @escaping () -> Void) {
        Task.init {
            do {
                items = try await webService.getAllFoods()
                completion()
            } catch {
                await UIAlertController.showAlert(message: K.Alert.fetchingError, from: vc)
            }
        }
    }
    
}
