//
//  HomeViewModel.swift
//  PizzaShop
//
//  Created by Arman Abkar on 12/15/21.
//

import SwiftUI
import MapKit

final class HomeViewModel: ObservableObject {
    
    var images: [ImageResource] = [.img1, .img2, .img3, .img4, .img5, .img6]
    let coordinate = CLLocationCoordinate2D(latitude: K.Information.locationLatitude,
                                                                longitude: K.Information.locationLongitude)
    @Published var position = MapCameraPosition.region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: K.Information.locationLatitude,
                                       longitude: K.Information.locationLongitude),
        span: MKCoordinateSpan(latitudeDelta: 0.01,
                               longitudeDelta: 0.075)
    ))
    
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

