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
                ZStack(alignment: .bottomTrailing) {
                    Image(.store)
                        .resizable()
                        .scaledToFill()
                        .cornerRadius(8)
                    VStack (spacing: 0) {
                        Text(K.Information.appName)
                            .font(.custom(K.Fonts.pizzaHut, size: 40))
                        Text(K.Information.freeIran)
                            .font(.custom(K.Fonts.pizzaHut, size: 16))
                    }
                    .padding(5)
                    .background(Color.black.opacity(0.75))
                    .cornerRadius(8)
                    .padding(10)
                }
                .padding(.bottom)
                
                VStack(spacing: 15) {
                    Text(K.Information.description1)
                        .multilineTextAlignment(.center)
                        .font(.title3)
                    Text(K.Information.description2)
                        .multilineTextAlignment(.center)
                        .font(.title3)
                    
                    GalleryView()
                    
                    ContactView(title: "Phone",
                                K.Information.supportPhone)
                    ContactView(title: "Address",
                                K.Information.address)
                    
                    MapView()
                    
                    Text(K.Information.copyright)
                }
            }
            .padding(.horizontal)
            .padding(.vertical)
        }
        .foregroundColor(.white)
    }
    
    @ViewBuilder
    func GalleryView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(homeViewModel.images ,
                        id:\.self) { image in
                    Image(image)
                        .resizable()
                        .frame(width: 140, height: 100)
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(8)
                }
            }
        }
        .padding(.vertical, 10)
    }
    
    @ViewBuilder
    func MapView() -> some View {
        Map(position: $homeViewModel.position) {
            Marker(K.Information.appName,
                   coordinate: homeViewModel.coordinate)
        }
        .frame(height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    @ViewBuilder
    func ContactView(title: String, _ value: String) -> some View {
        HStack {
            Text(title)
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .fontWeight(.bold)
                .multilineTextAlignment(.trailing)
        }
    }
}

#Preview {
    HomeView()
}
