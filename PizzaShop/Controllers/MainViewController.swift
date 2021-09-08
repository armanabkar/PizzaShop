//
//  MainViewController.swift
//  PizzaShop
//
//  Created by Arman Abkar on 9/5/21.
//

import UIKit
import MapKit

class MainViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showRestaurantLocation()
    }

    func showRestaurantLocation() {
        var c = CLLocationCoordinate2D()
        c.latitude = 34.402341
        c.longitude = -119.726045
        
        let a = MKPointAnnotation()
        a.coordinate = c
        a.title = "Pizza Pizza"
        mapView.addAnnotation(a)
        
        let restaurantLocation = CLLocationCoordinate2D(latitude: 34.402341, longitude: -119.726045)
        mapView.setCenter(restaurantLocation, animated: true)
        
        let viewRegion = MKCoordinateRegion(center: c, latitudinalMeters: 1500, longitudinalMeters: 1500)
        mapView.setRegion(viewRegion, animated: false)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
