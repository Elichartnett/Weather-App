//
//  DeniedView.swift
//  Weather
//
//  Created by Eli Hartnett on 12/2/21.
//

import SwiftUI

struct DeniedView: View {
    
    @EnvironmentObject var openWeatherResponseModel: OpenWeatherResponseModel
    @EnvironmentObject var locationModel: LocationModel
    
    @State var spinning = false
    let spinAnimation = Animation.linear(duration: 5).repeatForever(autoreverses: false)
    
    
    var body: some View {
        ZStack {
            Color.red
            VStack {
                Image(systemName: "sun.max").onAppear {
                    spinning = true
                }
                .rotationEffect(Angle(degrees: spinning ? 360 : 0))
                .animation(spinAnimation, value: spinning)
                
                Text("Location services status: \(locationModel.authorizationStatus)")
            }
        }
        .ignoresSafeArea()
    }
}


struct DeniedView_Previews: PreviewProvider {
    static var previews: some View {
        DeniedView()
            .environmentObject(LocationModel())
            .environmentObject(OpenWeatherResponseModel())
    }
}
