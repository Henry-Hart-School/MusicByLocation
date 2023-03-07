//
//  ContentView.swift
//  MusicByLocation
//
//  Created by Hart, Henry (AGDF) on 02/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var state = StateController()
    
    var body: some View {
        VStack {
            //Text(state.artistNames)
            Text(state.findMusicOutput)
                .padding()
            Spacer()
            Button("Find Music", action: {
                state.findMusic()
                //state.getArtists()
                
            })
        }.onAppear {
            state.requestAccessToLocationData()
            //state.getArtists()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
