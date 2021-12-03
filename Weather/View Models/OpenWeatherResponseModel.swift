//
//  OpenWeatherModel.swift
//  Weather
//
//  Created by Eli Hartnett on 12/1/21.
//

import Foundation
import UIKit

class OpenWeatherResponseModel: ObservableObject {
        
    @Published var openWeatherResponse: OpenWeatherResponse?
    let apiKey = "5ee3ddf1d1ef2e42b9161c91f1de2049"
    
    
    func getWeatherData(lat: String, lon: String) {
        let apiUrl = "https://api.openweathermap.org/data/2.5/weather"
        var urlComponents = URLComponents(string: apiUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "lat", value: lat),
            URLQueryItem(name: "lon", value: lon),
            URLQueryItem(name: "units", value: "imperial"),
            URLQueryItem(name: "appid", value: apiKey)
        ]
        if let url = urlComponents?.url {
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            
            let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
                if error == nil {
                    do {
                        let result = try JSONDecoder().decode(OpenWeatherResponse.self, from: data!)
                        DispatchQueue.main.async {
                            self.openWeatherResponse = result
                        }
                    }
                    catch {
//                        print(String(error.localizedDescription))
                        print(String(describing: error))
                    }
                }
                else {
//                    print(String(error!.localizedDescription))
                    print(String(describing: error))
                }
            }
            dataTask.resume()
        }
    }
    
    func formatTemp() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let temp = formatter.string(for: self.openWeatherResponse?.main?.temp)
        return temp ?? ""
    }
}
