//
//  HomeView.swift
//  Weather
//
//  Created by Eli Hartnett on 12/1/21.
//

import SwiftUI
import MapKit

struct HomeView: View {
    
    @EnvironmentObject var openWeatherResponseModel: OpenWeatherResponseModel
    @EnvironmentObject var locationModel: LocationModel
    
    
    var body: some View {
        ZStack {
            if let temp = openWeatherResponseModel.openWeatherResponse?.main?.temp {
                if temp < 40 {
                    Color.blue
                }
                else if temp >= 40 && temp < 60 {
                    Color.yellow
                }
                else if temp >= 60 && temp < 70 {
                    Color.orange
                }
                else {
                    Color.red
                }
            }
            else {
                Color.gray
            }
            VStack {
                Text("\(locationModel.city ?? "City"), \(locationModel.state ?? "State")")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                MapView()
                
                Text(openWeatherResponseModel.openWeatherResponse?.weather?.first?.description ?? "Description")
                
                if openWeatherResponseModel.openWeatherResponse?.weather?.first?.icon != nil {
                    let imageString = openWeatherResponseModel.openWeatherResponse!.weather!.first!.icon
                    let urlString = "https://openweathermap.org/img/wn/\(imageString!)@4x.png"
                    AsyncImage(url: URL(string: urlString)) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                Text("\(openWeatherResponseModel.formatTemp() != "" ?openWeatherResponseModel.formatTemp() : "Temperature")º")
                    .font(.largeTitle)
                
            }.onAppear {
                openWeatherResponseModel.getWeatherData(lat: locationModel.lat?.formatted() ?? "", lon: locationModel.lon?.formatted() ?? "")
            }
        }
        .ignoresSafeArea()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(LocationModel())
            .environmentObject(OpenWeatherResponseModel())
    }
}
