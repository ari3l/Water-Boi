//
//  LocationHelper.swift
//
//
//  Created by Ariel Steinlauf on 3/10/17.
//  Copyright © 2017 Ariel. All rights reserved.
//
import Foundation
import CoreLocation

class LocationHelper: NSObject, CLLocationManagerDelegate {
    
    static let sharedInstance = LocationHelper()
    
    enum LocationResponse {
        case success(CLLocation)
        case error(Error)
        case dennied
    }
    
    var locationManager:CLLocationManager!
    
    typealias LocationAuthBlock = (Bool) -> Void
    
    typealias LocationBlock = (LocationResponse) -> Void

    var locationAuth: LocationAuthBlock?

    var location: LocationBlock?
    
    override init() {
        super.init()
        
        self.locationManager = CLLocationManager()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        self.locationManager.delegate = self
    }
    
    func getCurrentLocation(_ completion: @escaping LocationBlock) {
        
        if needsPermission() {
            askAuth({ (authorized) in
                if authorized {
                    self.locationManager.startUpdatingLocation()
                    self.location = completion
                }
            })
        } else if isDenied() {
            completion(.dennied)
            
        } else {
            self.locationManager.startUpdatingLocation()
            self.location = completion
        }
    }

    func needsPermission() -> Bool {
        let status = CLLocationManager.authorizationStatus()
        return status == .notDetermined
    }
    
    func isDenied() -> Bool {
        let status = CLLocationManager.authorizationStatus()
        return status == .denied
    }
    
    func askAuth(_ completion: @escaping LocationAuthBlock) {
        self.locationAuth = completion
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.location?(.error(error))
        location = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationAuth?(true)
        }
        else {
            locationAuth?(false)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        if let location = locations.first {
            self.location?(.success(location))
        }
        self.location = nil
    }
    
}
