//
//  ProfileViewModel.swift
//  PizzaShop
//
//  Created by Arman Abkar on 12/15/21.
//

import UIKit
import Combine

final class ProfileViewModel: ObservableObject {
    
    func getAppVersion() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary[K.CFBundleShortVersionString] as! String
        let build = dictionary[K.CFBundleVersion] as! String
        
        return "Version \(version)(\(build))"
    }
    
    func removeAndResetUserData(from vc: UIViewController) {
        UserDefaultsService.shared.removeUserFromUserDefaults()
        CoreDataService.shared.resetAllRecords(in: K.CoreData.entityName) { result in
            switch result {
                case .success(_):
                    vc.performSegue(withIdentifier: K.authSegue, sender: nil)
                case .failure(let error):
                    UIAlertController.showAlert(message: error.localizedDescription, from: vc)
            }
            
        }
    }
    
}
