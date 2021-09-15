//
//  AuthViewController.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/26/21.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    
    var webService: API = WebService.shared // Property Injection - Can replace with stub in testing
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animateText(text: K.appName)
        
        self.nameField.delegate = self
        self.phoneField.delegate = self
        self.addressField.delegate = self
    }
    
    
    @IBAction func registerTapped(_ sender: UIButton) {
        if let name = nameField.text,
           let phone = phoneField.text,
           let address = addressField.text,
           nameField.text != "" && phoneField.text != "" && addressField.text != "" {
            let newUser = User(name: name, phone: phone, address: address)
            webService.register(user: newUser) { result in
                switch result {
                    case .success(let user):
                        UserDefaultsService.shared.saveToUserDefaults(name: user!.name, phone: user!.phone, address: user!.address)
                        self.performSegue(withIdentifier: K.menuSegue, sender: nil)
                    case .failure(let error):
                        switch error {
                            case .custom(K.Alert.userAlreadyExists):
                                UIAlertController.showAlert(message: K.Alert.userAlreadyExists, from: self)
                            default:
                                UIAlertController.showAlert(message: error.localizedDescription, from: self)
                        }
                }
            }
        }
        else {
            UIAlertController.showAlert(message: K.Alert.invalidFieldMessage, from: self)
        }
    }
    
    private func animateText(text: String) {
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
