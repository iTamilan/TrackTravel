//
//  LocationManager.swift
//  TrackMe
//
//  Created by Tamilarasu on 14/04/18.
//  Copyright © 2018 Itamilan. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

protocol LocationManagerDelegate: CLLocationManagerDelegate {
    func didUpdate(location: CLLocation)
}

class LocationManager: NSObject {
    static let shared = LocationManager()
    
    private let manager = CLLocationManager()
    
    private var delegates = [LocationManagerDelegate]()
    private var bestLocation: CLLocation? //CLLocation(latitude: 12.97194, longitude: 77.59369)
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        if CLLocationManager.locationServicesEnabled() {
            manager.requestAlwaysAuthorization()
            manager.startUpdatingLocation()
        }
        OperationQueue.main.addOperation {
            self.startTrack()
        }
    }
    
    func startTrack() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            print("Not determined")
            showLocationAlert()
        case .authorizedAlways:
            print("Authorized always")
        case .denied:
            print("Denied")
            showLocationAlert()
        case .authorizedWhenInUse:
            print("When in use")
            showLocationAlert()
        case .restricted:
            print("Restricted")
            showLocationAlert()
        }
        
    }
    
    func showLocationAlert() {
        
        getTopViewController().showAlert(withTitile: "Permission",
                                         message: "\"Track me\" requires location permission to track your complete location",
                                         cancelTitle: "Cancel",
                                         titleList: ["Open Settings"])
        { (title, index) in
            if index == 1 {
                UIApplication.shared.open(URL(string:UIApplicationOpenSettingsURLString)!, options: [:],
                                          completionHandler: .none)
            }
        }
    }
    
    func addDelegate(_ delegate: LocationManagerDelegate) {
        weak var weakDelegate = delegate
        if let weakenDelegate = weakDelegate {
            delegates.append(weakenDelegate)
            if let location = bestLocation {
                weakDelegate?.didUpdate(location: location)
            }
        }
    }
    
    func removeDelegate(_ delegate: LocationManagerDelegate) {
        for (index, addedDelegate) in delegates.enumerated() {
            if addedDelegate.isEqual(delegate) {
                delegates.remove(at: index)
            }
        }
    }
    
    func updateBestLocation(_ locations: [CLLocation]) {
        for location in locations {
            updateBestLocation(location)
        }
    }
    
    func updateBestLocation(_ location: CLLocation) {
        if isBestLocation(location){
            bestLocation = location
        }
    }
    
    func isBestLocation(_ location: CLLocation) -> Bool {
        if let bestlocation = bestLocation {
            return location.horizontalAccuracy < bestlocation.horizontalAccuracy
        } else {
            return true
        }
    }
    
    private func getTopViewController() -> UIViewController {
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            return rootViewController.topViewController()
        }
        return UIViewController()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        updateBestLocation(locations)
        if let bestLocation = bestLocation {
            for delegate in delegates {
                delegate.didUpdate(location: bestLocation)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error \(error)")
    }
}
