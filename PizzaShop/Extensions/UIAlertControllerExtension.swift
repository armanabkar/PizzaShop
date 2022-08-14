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
        
        DispatchQueue.main.async {
            controller.present(alertController, animated: true, completion: nil)
        }
    }
    
    static func confirmationAlert(title: String? = K.Alert.confirmationTitle,
                                  from controller: UIViewController,
                                  action: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let logOutAction = UIAlertAction(title: "Log Out", style: .destructive, handler: action)
        
        alertController.addAction(cancelAction)
        alertController.addAction(logOutAction)
        
        DispatchQueue.main.async {
            controller.present(alertController, animated: true, completion: nil)
        }
    }
    
}
