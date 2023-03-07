//
//  StateController.swift
//  MusicByLocation
//
//  Created by Hart, Henry (AGDF) on 07/03/2023.
//

import Foundation

class StateController: ObservableObject {
    @Published var lastKnownLocation : String = "" {
        didSet {
            print(lastKnownLocation)
            getArtists(term: lastKnownLocation)
        }
    }
    @Published var artistNames : String = ""
    @Published var findMusicOutput : String = ""
    let locationHandler: LocationHandler = LocationHandler()
    
    func findMusic() {
        locationHandler.requestLocation()
    }
    
    func requestAccessToLocationData() {
        locationHandler.stateController = self
        locationHandler.requestAuthorisation()
    }
    
    func getArtists(term: String) {
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(term)&entity=musicArtist")
        else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request){ (data, response, error) in
            if let data = data {
                //print(String(decoding: data, as: UTF8.self))
                if let response = self.parseJson(json: data) {
                    let names = response.results.map {
                        return $0.name
                    }
                    
                    DispatchQueue.main.async {
                        self.findMusicOutput = names.joined(separator: ",")
                    }
                }
            }
        }.resume()
    }
    
    func parseJson(json: Data) -> ArtistResponse? {
        let decoder = JSONDecoder()
        let artistResponse = try? decoder.decode(ArtistResponse.self, from: json)
        if artistResponse == nil {
            print("Error decoding JSON")
        }
        return artistResponse
    }
}
