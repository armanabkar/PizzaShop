//
//  AuthViewController.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/26/21.
//

import UIKit

class AuthViewController: UIViewController {
    
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animateText(K.appName)
    }
    
    
    @IBAction func registerTapped(_ sender: UIButton) {
        if let name = nameField.text,
           let phone = phoneField.text,
           let address = addressField.text,
           nameField.text != "" && phoneField.text != "" && addressField.text != "" {
            saveToUserDefaults(name: name, phone: phone, address: address)
            self.performSegue(withIdentifier: K.menuSegue, sender: nil)
        }
        else {
            UIAlertController.showAlert(message: "Fields are empty", from: self)
        }
    }
    
    private func animateText(_ text: String) {
        appTitle.text = ""
        var charIndex = 0.0
        let titleText = text
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.appTitle.text?.append(letter)
            }
            charIndex += 1
        }
    }
    
    private func saveToUserDefaults(name: String, phone: String, address: String) {
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(phone, forKey: "phone")
        UserDefaults.standard.set(address, forKey: "address")
    }
    
}
