//
//  UserDefaultsService.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/30/21.
//

import UIKit

final class UserDefaultsService {
    
    private init() {}
    static let shared = UserDefaultsService()
    private let UD = UserDefaults.standard
    
    var name: String {
        UD.string(forKey: "name") ?? ""
    }
    var phone: String {
        UD.string(forKey: "phone") ?? ""
    }
    var address: String {
        UD.string(forKey: "address") ?? ""
    }
    
    /// Save the user's information to the User Defaults
    func saveUser(user: User) {
        UD.set(user.name, forKey: "name")
        UD.set(user.phone, forKey: "phone")
        UD.set(user.address, forKey: "address")
    }
    
    /// Remove the user's information from the User Defaults
    func removeUser() {
        UD.removeObject(forKey: "name")
        UD.removeObject(forKey: "phone")
        UD.removeObject(forKey: "address")
    }
    
}
