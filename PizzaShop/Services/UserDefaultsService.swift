//
//  UserDefaultsService.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/30/21.
//

import UIKit

final class UserDefaultsService {
    
    static let shared = UserDefaultsService()
    private init() {}
    
    var name: String {
        UserDefaults.standard.string(forKey: "name") ?? ""
    }
    var phone: String {
        UserDefaults.standard.string(forKey: "phone") ?? ""
    }
    var address: String {
        UserDefaults.standard.string(forKey: "address") ?? ""
    }
    
    func saveToUserDefaults(user: User) {
        UserDefaults.standard.set(user.name, forKey: "name")
        UserDefaults.standard.set(user.phone, forKey: "phone")
        UserDefaults.standard.set(user.address, forKey: "address")
    }
    
    func removeUserFromUserDefaults() {
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "phone")
        UserDefaults.standard.removeObject(forKey: "address")
    }
    
}
