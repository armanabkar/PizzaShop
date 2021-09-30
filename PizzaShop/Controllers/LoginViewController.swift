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
    
    var webService: API = WebService.shared 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.phoneField.delegate = self
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        guard let phone = phoneField.text,
              phone != "" else {
            UIAlertController.showAlert(message: K.Alert.invalidFieldMessage, from: self)
            return
        }
        
        webService.login(phone: User(name: "", phone: phone, address: "")) { [weak self] result in
            switch result {
                case .success(let user):
                    UserDefaultsService.shared.saveToUserDefaults(user: user!)
                    self?.performSegue(withIdentifier: K.menuSegue, sender: nil)
                case .failure(let error):
                    switch error {
                        case .custom(K.Alert.userDoesNotExist):
                            UIAlertController.showAlert(message: K.Alert.userDoesNotExist, from: self!)
                        default:
                            UIAlertController.showAlert(message: error.localizedDescription, from: self!)
                    }
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
