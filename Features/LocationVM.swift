//
//  LocationVM.swift
//  DrinkLink
//
//  Created by Rebecca Shu on 3/27/22.
//

import Foundation
import CoreLocation
import MapKit

class LocationVM: NSObject, ObservableObject {
    @Published var userLatitude: Double = 0
    @Published var userLongitude: Double = 0
    @Published var region = MKCoordinateRegion()
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
}
extension LocationVM: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        userLatitude = location.coordinate.latitude
        userLongitude = location.coordinate.longitude
        //        locations.last.map {
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: userLatitude, longitude: userLongitude),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
        //        }
        //        print(userLatitude)
        //        print(userLongitude)
    }
}
