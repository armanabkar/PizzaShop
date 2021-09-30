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
    @IBOutlet weak var appVersionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = UserDefaultsService.shared.name
        phoneLabel.text = UserDefaultsService.shared.phone
        addressLabel.text = UserDefaultsService.shared.address
        appVersionLabel.text = getAppVersion()
    }
    
    
    @IBAction func logOutTapped(_ sender: UIButton) {
        removeAndResetUserData()
    }
    
    @IBAction func emailButtonTapped(_ sender: Any) {
        showMailComposer()
    }
    
    @IBAction func callButtonTapped(_ sender: Any) {
        if let url = URL(string: "tel://\(K.supportPhone)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func removeAndResetUserData() {
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
    
    func getAppVersion() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary[K.CFBundleShortVersionString] as! String
        let build = dictionary[K.CFBundleVersion] as! String
        
        return "Version \(version)(\(build))"
    }
}

extension ProfileViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func showMailComposer() {
        guard MFMailComposeViewController.canSendMail() else {
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients([K.supportEmail])
        composer.setMessageBody("", isHTML: false)
        
        present(composer, animated: true)
    }
    
}
