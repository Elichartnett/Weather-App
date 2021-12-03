//
//  WeatherApp.swift
//  Weather
//
//  Created by Eli Hartnett on 12/1/21.
//

import SwiftUI

@main
struct WeatherApp: App {

    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(LocationModel())
                .environmentObject(OpenWeatherResponseModel())
        }
    }
}
