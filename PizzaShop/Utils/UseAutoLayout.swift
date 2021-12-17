//
//  UseAutoLayout.swift
//  PizzaShop
//
//  Created by Arman Abkar on 12/16/21.
//

import UIKit

@propertyWrapper
struct UseAutoLayout<T: UIView> {
    public var wrappedValue: T {
        didSet {
            setAutoLayout()
        }
    }
    
    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        setAutoLayout()
    }
    
    func setAutoLayout() {
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}
