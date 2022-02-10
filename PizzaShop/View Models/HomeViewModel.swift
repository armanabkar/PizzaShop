//
//  HomeViewModel.swift
//  PizzaShop
//
//  Created by Arman Abkar on 12/15/21.
//

import SwiftUI
import MapKit

final class HomeViewModel: ObservableObject {
    
    let places = [
        Place(name: K.Information.appName,
              latitude: K.Information.locationLatitude,
              longitude: K.Information.locationLongitude)
    ]
    var images: [String] = []
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: K.Information.locationLatitude,
                                       longitude: K.Information.locationLongitude),
        span: MKCoordinateSpan(latitudeDelta: 0.1,
                               longitudeDelta: 0.1)
    )
    
    init() {
        Task.init {
            let foods = try await WebService.shared.getAllFoods()
            foods
                .filter({ food in
                    food.type == "pizza"
                })
                .forEach { food in
                images.append("\(K.URL.baseUrl)/\(food.image)")
            }
        }
    }
    
}

struct Place: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

