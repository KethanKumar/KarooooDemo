//
//  LocationManager.swift
//  DemoApp
//
//  Created by Kethan on 20/09/22..
//

import UIKit
import Foundation
import CoreLocation

class LocationManager: NSObject {
    
    static let shared = LocationManager()
    static var lat: String? = nil
    static var long: String? = nil
    
    var locationManager =  CLLocationManager()
    var completionHandler: ((CLLocation) -> Void)?

    func getUserLocation(completion: @escaping ((CLLocation) -> Void)) {
        self.completionHandler = completion
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func setUserLocationInApiHeader() {
        if LocationManager.shared.isLocationEnabled() {
            LocationManager.shared.getUserLocation { _ in }
        }
    }
    
    func isLocationEnabled() -> Bool {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        default:
            return false
        }
    }

}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.setGeoLocation(location: location)
        completionHandler?(location)
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let status = CLLocationManager.authorizationStatus()
        
        if status == .notDetermined { return }
        
        self.openSettingsAlert()
        locationManager.stopUpdatingLocation()
    }

    func setGeoLocation(location: CLLocation) {
        LocationManager.lat = String(location.coordinate.latitude)
        LocationManager.long = String(location.coordinate.longitude)
    }
    
}

private extension LocationManager {
    
    func openSettingsAlert() {
        let alert = UIAlertController(
            title: "DemoApp",
            message: "Enable location from Settings",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
                            title: "Continue",
                            style: .default,
                            handler: { (_) in
                                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                                    return
                                }
                                UIApplication.shared.open(settingsUrl)
                            })
        )

        guard let rootViewController = UIApplication.getTopViewController() else { return }
        rootViewController.present(alert, animated: true, completion: nil)
    }
    
}
