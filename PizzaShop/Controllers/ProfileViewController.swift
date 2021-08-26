//
//  ProfileViewController.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/27/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = UserDefaults.standard.string(forKey: "name")
        phoneLabel.text = UserDefaults.standard.string(forKey: "phone")
        addressLabel.text = UserDefaults.standard.string(forKey: "address")
    }
    
    @IBAction func logOutTapped(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "phone")
        UserDefaults.standard.removeObject(forKey: "address")
        self.performSegue(withIdentifier: K.authSegue, sender: nil)
    }
}
