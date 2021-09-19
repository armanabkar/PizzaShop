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
    
    func saveToUserDefaults(name: String, phone: String, address: String) {
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(phone, forKey: "phone")
        UserDefaults.standard.set(address, forKey: "address")
    }
    
    func removeUserFromUserDefaults() {
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "phone")
        UserDefaults.standard.removeObject(forKey: "address")
    }
    
}
