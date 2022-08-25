//
//  HomeViewController.swift
//  PizzaShop
//
//  Created by Arman Abkar on 9/5/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeView = HomeView()
        addSubSwiftUIView(homeView, to: view)
        becomeFirstResponder()
        
        createObservers()
        NotificationCenter.default.post(name: K.Identifiers.badgeNotification,
                                        object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func createObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(HomeViewController.updateBadge(notification:)),
                                               name: K.Identifiers.badgeNotification,
                                               object: nil)
    }
    
    @objc func updateBadge(notification: NSNotification) {
        CoreDataService.shared.loadCartItems { result in
            switch result {
                case .success(let cart):
                    self.tabBarController?.tabBar.items?[2].badgeValue = cart.count != 0 ? "\(cart.count)" : nil
                    self.tabBarController?.tabBar.items?[2].badgeColor = .gray
                case .failure(let error):
                    UIAlertController.showAlert(message: "Error updating badge: \(error.localizedDescription)",
                                                from: self)
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            UIAlertController.showAlert(title: K.Alert.shakeTitle,
                                        message: K.Alert.shakeMessage,
                                        from: self)
        }
    }
    
}
