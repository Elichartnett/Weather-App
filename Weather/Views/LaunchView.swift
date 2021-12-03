//
//  LaunchView.swift
//  Weather
//
//  Created by Eli Hartnett on 12/2/21.
//

import SwiftUI

struct LaunchView: View {
    
    @EnvironmentObject var locationModel: LocationModel
    
    
    var body: some View {
        VStack {
            if locationModel.authorizationStatus != "On" {
                DeniedView()
            }
            else {
                HomeView()
            }
        }.onAppear {
            locationModel.checkLocationServices()
        }
    }
}


struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
            .environmentObject(LocationModel())
    }
}
