//
//  AuthViewController.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/26/21.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    
    var webService: API = WebService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animateText(text: K.appName)
        
        self.nameField.delegate = self
        self.phoneField.delegate = self
        self.addressField.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func registerTapped(_ sender: UIButton) {
        registerUser()
    }
    
    func animateText(text: String) {
        DispatchQueue.main.async {
            self.appTitle.text = ""
            var charIndex = 0.0
            let titleText = text
            for letter in titleText {
                Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                    self.appTitle.text?.append(letter)
                }
                charIndex += 1
            }
        }
    }
    
    func registerUser() {
        guard let name = nameField.text,
              let phone = phoneField.text,
              let address = addressField.text,
              name != "" && phone != "", address != "" else {
            UIAlertController.showAlert(message: K.Alert.invalidFieldMessage, from: self)
            return
        }
        
        let newUser = User(name: name, phone: phone, address: address)
        webService.register(user: newUser) { [weak self] result in
            switch result {
                case .success( _):
                    UserDefaultsService.shared.saveToUserDefaults(user: newUser)
                    self?.performSegue(withIdentifier: K.menuSegue, sender: nil)
                case .failure(let error):
                    switch error {
                        case .custom(K.Alert.userAlreadyExists):
                            UIAlertController.showAlert(message: K.Alert.userAlreadyExists, from: self!)
                        default:
                            UIAlertController.showAlert(message: error.localizedDescription, from: self!)
                    }
            }
        }
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
