//
//  ProfileViewController.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/27/21.
//

import UIKit
import MessageUI

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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func logOutTapped(_ sender: UIButton) {
        UserDefaultsService.shared.removeUserFromUserDefaults()
        CoreDataService.shared.resetAllRecords(in: K.CoreData.entityName) { result in
            switch result {
                case .success(_):
                    self.performSegue(withIdentifier: K.authSegue, sender: nil)
                case .failure(let error):
                    UIAlertController.showAlert(message: error.localizedDescription, from: self)
            }
            
        }
    }
    
    @IBAction func emailButtonTapped(_ sender: Any) {
        guard MFMailComposeViewController.canSendMail() else {
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["support@pizzapizza.com"])
        composer.setMessageBody("Hi...", isHTML: false)
        
        present(composer, animated: true)
    }
    
    @IBAction func callButtonTapped(_ sender: Any) {
        if let url = URL(string: "tel://8056814200"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}

extension ProfileViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}
