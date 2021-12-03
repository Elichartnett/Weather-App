//
//  LocationModel.swift
//  Weather
//
//  Created by Eli Hartnett on 12/1/21.
//

import Foundation
import CoreLocation

class LocationModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    var locationManager: CLLocationManager?
    @Published var city: String?
    @Published var state: String?
    @Published var lat: CLLocationDegrees?
    @Published var lon: CLLocationDegrees?
    @Published var authorizationStatus = ""
    
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        }
        else {
            print("Show alert - Location services not turned on")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else {
            return
        }
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            authorizationStatus = "Not determined"
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            authorizationStatus = "Restricted"
        case .denied:
            authorizationStatus = "Denied"
        case .authorizedAlways, .authorizedWhenInUse:
            authorizationStatus = "On"
            getCoordinates()
            getCity()
            getState()
            break
        @unknown default:
            authorizationStatus = "Unknown"
            break
        }
    }
    
    func getCoordinates() {
        if let locationManager = locationManager {
            if locationManager.authorizationStatus == .authorizedWhenInUse {
                lat = locationManager.location?.coordinate.latitude
                lon = locationManager.location?.coordinate.longitude
            }
        }
    }
    
    func getCity() {
        if let location = locationManager?.location {
            if locationManager?.authorizationStatus == .authorizedWhenInUse {
                let geoCoder = CLGeocoder()
                geoCoder.reverseGeocodeLocation(location) { placemarks, error in
                    guard error == nil else {
                        print(error!.localizedDescription)
                        return
                    }
                    let placemark = placemarks?.first
                    self.city = placemark?.locality ?? ""
                }
            }
        }
    }
    
    func getState() {
        if let location = locationManager?.location {
            if locationManager?.authorizationStatus == .authorizedWhenInUse {
                let geoCoder = CLGeocoder()
                geoCoder.reverseGeocodeLocation(location) { placemarks, error in
                    guard error == nil else {
                        print(error!.localizedDescription)
                        return
                    }
                    let placemark = placemarks?.first
                    self.state = placemark?.administrativeArea ?? ""
                }
            }
        }
    }
}
