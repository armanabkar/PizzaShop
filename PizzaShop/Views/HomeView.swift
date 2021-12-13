//
//  HomeView.swift
//  PizzaShop
//
//  Created by Arman Abkar on 12/12/21.
//

import SwiftUI
import MapKit

struct HomeView: View {
    
    let places = [
        Place(name: "Pizza Pizza", latitude: 34.402341, longitude: -119.726045)
    ]
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 34.402341, longitude: -119.726045),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ScrollView {
                Image("store")
                    .resizable()
                    .scaledToFill()
                
                VStack(spacing: 15) {
                    Text("Pizza Pizza !")
                        .font(.system(size: 42, weight: .heavy, design: .rounded))
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        .background()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    Text("Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, tempor incididunt ut magna aliqua. ut labore et dolore magna aliqua.")
                        .foregroundColor(.white.opacity(0.85))
                        .multilineTextAlignment(.center)
                        .font(.title2)
                    Text("sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. tempor incididunt ut labore et dolore magna magna et dolrore!")
                        .foregroundColor(.white.opacity(0.85))
                        .multilineTextAlignment(.center)
                        .font(.title2)
                    Text("☎️ (805) 681- 4200")
                        .foregroundColor(.white)
                        .font(.title2)
                }
                .padding(.horizontal)
                .padding(.vertical, 20)
                
                Map(coordinateRegion: $region,
                    showsUserLocation: false,
                    annotationItems: places) { place in
                    MapMarker(coordinate: place.coordinate)
                }
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.horizontal)
            }
            .ignoresSafeArea()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
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
