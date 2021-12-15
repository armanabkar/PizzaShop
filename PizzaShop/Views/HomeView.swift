//
//  HomeView.swift
//  PizzaShop
//
//  Created by Arman Abkar on 12/12/21.
//

import SwiftUI
import MapKit

struct HomeView: View {
    
    @StateObject private var homeViewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ScrollView {
                Image(K.Images.storeImage)
                    .resizable()
                    .scaledToFill()
                
                VStack(spacing: 15) {
                    Text(K.appName)
                        .font(.system(size: 40, weight: .heavy, design: .rounded))
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        .background()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Text(K.description1)
                        .foregroundColor(.white.opacity(0.85))
                        .multilineTextAlignment(.center)
                        .font(.title2)
                    Text(K.description2)
                        .foregroundColor(.white.opacity(0.85))
                        .multilineTextAlignment(.center)
                        .font(.title2)
                    
                    Spacer()
                    Text("☎️ \(K.supportPhone)")
                        .foregroundColor(.white)
                        .font(.title3)
                    
                    Map(coordinateRegion: $homeViewModel.region,
                        showsUserLocation: false,
                        annotationItems: homeViewModel.places) {
                        MapMarker(coordinate: $0.coordinate)
                    }
                        .frame(height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding(.horizontal)
                .padding(.vertical, 20)
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
