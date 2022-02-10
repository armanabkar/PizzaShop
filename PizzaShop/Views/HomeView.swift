//
//  HomeView.swift
//  PizzaShop
//
//  Created by Arman Abkar on 12/12/21.
//

import SwiftUI
import MapKit

struct HomeView: View {
    
    @ObservedObject private var homeViewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ScrollView {
                Image(K.Images.storeImage)
                    .resizable()
                    .scaledToFill()
                
                VStack(spacing: 15) {
                    Text(K.Information.appName)
                        .font(.system(size: 40, weight: .heavy, design: .rounded))
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        .background()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Text(K.Information.description1)
                        .foregroundColor(.white.opacity(0.85))
                        .multilineTextAlignment(.center)
                        .font(.title2)
                    Text(K.Information.description2)
                        .foregroundColor(.white.opacity(0.85))
                        .multilineTextAlignment(.center)
                        .font(.title2)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0..<homeViewModel.images.count) { i in
                                AsyncImage(url: URL(string: "\(homeViewModel.images[i])")) { image in
                                    image
                                        .resizable()
                                        .frame(width: 140, height: 100)
                                        .aspectRatio(contentMode: .fill)
                                        .cornerRadius(8)
                                } placeholder: {
                                    Color.white
                                        .frame(width: 140, height: 100)
                                        .cornerRadius(8)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 10)
                    
                    Text("☎️ \(K.Information.supportPhone)")
                        .foregroundColor(.white)
                        .font(.title3)
                    Text("🌴 \(K.Information.address)")
                        .foregroundColor(.white)
                        .font(.title3)
                    
                    Map(coordinateRegion: $homeViewModel.region,
                        showsUserLocation: false,
                        annotationItems: homeViewModel.places) {
                        MapMarker(coordinate: $0.coordinate)
                    }
                        .frame(height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Text("\(K.Information.description3)")
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(.semibold)
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
