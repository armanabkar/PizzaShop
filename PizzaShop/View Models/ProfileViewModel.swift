//
//  ProfileViewModel.swift
//  PizzaShop
//
//  Created by Arman Abkar on 12/15/21.
//

import UIKit

final class ProfileViewModel {
    
    func getAppVersion() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary[K.Identifiers.CFBundleShortVersionString] as! String
        let build = dictionary[K.Identifiers.CFBundleVersion] as! String
        
        return "Version \(version)(\(build))"
    }
    
    func removeAndResetUserData(from vc: UIViewController) {
        UserDefaultsService.shared.removeUser()
        CoreDataService.shared.resetAllRecords(in: K.CoreData.entityName) { result in
            switch result {
                case .success(_):
                    vc.performSegue(withIdentifier: K.Identifiers.authSegue, sender: nil)
                case .failure(let error):
                    UIAlertController.showAlert(message: error.localizedDescription, from: vc)
            }
            
        }
    }
    
}
