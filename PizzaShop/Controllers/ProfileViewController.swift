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
        
        nameLabel.text = UserDefaultsService.name
        phoneLabel.text = UserDefaultsService.phone
        addressLabel.text = UserDefaultsService.address
    }
    
    @IBAction func logOutTapped(_ sender: UIButton) {
        UserDefaultsService.removeUserFromUserDefaults()
        CoreDataService.resetAllRecords(in: "Cart", from: self)
        self.performSegue(withIdentifier: K.authSegue, sender: nil)
    }
}
