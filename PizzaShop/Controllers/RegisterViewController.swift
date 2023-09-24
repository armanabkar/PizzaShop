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
        
        animateText()
        
        self.nameField.delegate = self
        self.phoneField.delegate = self
        self.addressField.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    @IBAction func registerTapped(_ sender: UIButton) {
        registerUser()
    }
    
    func animateText() {
        self.appTitle.text = ""
        var charIndex = 0.0
        let titleText = K.Information.appName
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.appTitle.text?.append(letter)
            }
            charIndex += 1
        }
    }
    
    func registerUser() {
        guard let name = nameField.text,
              let phone = phoneField.text,
              let address = addressField.text,
              !name.isEmpty && !phone.isEmpty && !address.isEmpty else {
            UIAlertController.showAlert(message: K.Alert.invalidFieldMessage, from: self)
            return
        }
        
        let newUser = User(name: name, phone: phone, address: address)
        sendRegisterRequest(user: newUser)
    }
    
    private func sendRegisterRequest(user: User) {
        Task.init {
            do {
                let user = try await webService.register(user: user)
                UserDefaultsService.shared.saveUser(user: user)
                self.performSegue(withIdentifier: K.Identifiers.menuSegue, sender: nil)
            } catch {
                UIAlertController.showAlert(message: K.Alert.userAlreadyExists, from: self)
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
