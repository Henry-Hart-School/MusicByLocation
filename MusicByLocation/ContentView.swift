//
//  ContentView.swift
//  MusicByLocation
//
//  Created by Hart, Henry (AGDF) on 02/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var locationHandler = LocationHandler()
    
    var body: some View {
        VStack {
            Text(locationHandler.lastKnownLocation)
                .padding()
            Spacer()
            Button("Find Music", action: {locationHandler.requestLocation()})
        }.onAppear {
            locationHandler.requestAuthorisation()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
