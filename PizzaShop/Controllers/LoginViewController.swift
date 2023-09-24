//
//  LoginViewController.swift
//  PizzaShop
//
//  Created by Arman Abkar on 9/8/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var phoneField: UITextField!
    
    var webService: API = WebService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.phoneField.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        loginUser()
    }
    
    func loginUser() {
        guard let phone = phoneField.text,
              !phone.isEmpty else {
            UIAlertController.showAlert(message: K.Alert.invalidFieldMessage, from: self)
            return
        }
        
        sendLoginRequest(phone: phone)
    }
    
    private func sendLoginRequest(phone: String) {
        Task.init {
            do {
                let user = try await webService.login(user: User(name: "", phone: phone, address: ""))
                UserDefaultsService.shared.saveUser(user: user)
                self.performSegue(withIdentifier: K.Identifiers.menuSegue, sender: nil)
            } catch {
                UIAlertController.showAlert(message: K.Alert.userDoesNotExist, from: self)
            }
        }
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
