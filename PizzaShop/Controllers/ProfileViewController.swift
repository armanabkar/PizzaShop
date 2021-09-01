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
        
        nameLabel.text = UserDefaultsService.shared.name
        phoneLabel.text = UserDefaultsService.shared.phone
        addressLabel.text = UserDefaultsService.shared.address
    }
    
    @IBAction func logOutTapped(_ sender: UIButton) {
        UserDefaultsService.shared.removeUserFromUserDefaults()
        CoreDataService.shared.resetAllRecords(in: K.coreDataEntityName, from: self)
        self.performSegue(withIdentifier: K.authSegue, sender: nil)
    }
}
