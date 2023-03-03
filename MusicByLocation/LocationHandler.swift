//
//  LocationHandler.swift
//  MusicByLocation
//
//  Created by Hart, Henry (AGDF) on 02/03/2023.
//

import Foundation
import CoreLocation

class LocationHandler : NSObject, CLLocationManagerDelegate, ObservableObject {
    let manager = CLLocationManager()
    let geocoder = CLGeocoder()
    @Published var lastKnownLocation: String = ""
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestAuthorisation() {
        manager.requestWhenInUseAuthorization()
    }
    
    func requestLocation() {
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let firstLocation = locations.first {
            geocoder.reverseGeocodeLocation(firstLocation, completionHandler: {(placemarks, error) in
                if error != nil {
                    self.lastKnownLocation = "ERROR! location lookup from coordinates failed!"
                } else {
                    if let firstPlacement = placemarks?[0] {
                        // um so just always work and never fail getting any of these
                        self.lastKnownLocation = "Place: \(firstPlacement.locality!) \nPOSTCODE: \(firstPlacement.postalCode!) \nCountry: \(firstPlacement.country!), \(firstPlacement.administrativeArea!) \nName: \(firstPlacement.name!) \nCoords [lat, long alt]: \(firstPlacement.location!.coordinate.latitude) \(firstPlacement.location!.coordinate.longitude) \(firstPlacement.location!.altitude)"
                        //?? "ERROR! Unable to find locality!"
                    }
                }
            })
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        lastKnownLocation = "ERROR! Unable to get location!"
    }
}
