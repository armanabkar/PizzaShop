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
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
