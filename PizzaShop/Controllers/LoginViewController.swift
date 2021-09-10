//
//  LoginViewController.swift
//  PizzaShop
//
//  Created by Arman Abkar on 9/8/21.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var phoneField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.phoneField.delegate = self
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        if let phone = phoneField.text, phoneField.text != "" {
            print(phone)
        }
        else {
            UIAlertController.showAlert(message: K.Alert.invalidFieldMessage, from: self)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
