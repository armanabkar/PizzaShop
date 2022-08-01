//
//  MainViewController.swift
//  PizzaShop
//
//  Created by Arman Abkar on 9/5/21.
//

import UIKit
import MapKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let homeView = HomeView()
        addSubSwiftUIView(homeView, to: view)
        becomeFirstResponder()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            UIAlertController.showAlert(message: K.Alert.shake, from: self)
        }
    }
    
}
