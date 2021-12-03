//
//  MapView.swift
//  Weather
//
//  Created by Eli Hartnett on 12/2/21.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @EnvironmentObject var openWeatherResponseModel: OpenWeatherResponseModel
    @EnvironmentObject var locationModel: LocationModel
    
    @State var lat: CLLocationDegrees?
    @State var lon: CLLocationDegrees?
    
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331676, longitude: -122.030189), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    
    var body: some View {
        Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: nil).onAppear(perform: {
            region.center = CLLocationCoordinate2D(latitude: locationModel.lat ?? 37.331676, longitude: locationModel.lon ?? -122.030189)
        })
        .frame(width: 300, height: 300)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding()
    }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(region: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.331676, longitude: -122.030189), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)))
            .environmentObject(LocationModel())
            .environmentObject(OpenWeatherResponseModel())
    }
}
