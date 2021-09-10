//
//  UIAlertControllerExtension.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/30/21.
//

import UIKit

extension UIAlertController {
    static func showAlert(title: String? = K.Alert.title, message: String, from controller: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(okAction)
        
        controller.present(alertController, animated: true, completion: nil)
    }
}
