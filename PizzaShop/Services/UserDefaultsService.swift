//
//  UserDefaultsService.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/30/21.
//

import UIKit

struct UserDefaultsService {
    
    static var name: String {
        UserDefaults.standard.string(forKey: "name") ?? ""
    }
    static var phone: String {
        UserDefaults.standard.string(forKey: "phone") ?? ""
    }
    static var address: String {
        UserDefaults.standard.string(forKey: "address") ?? ""
    }
    
    static func saveToUserDefaults(name: String, phone: String, address: String) {
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(phone, forKey: "phone")
        UserDefaults.standard.set(address, forKey: "address")
    }
    
    static func removeUserFromUserDefaults() {
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "phone")
        UserDefaults.standard.removeObject(forKey: "address")
    }
    
}
