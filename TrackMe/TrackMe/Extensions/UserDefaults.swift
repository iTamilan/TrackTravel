//
//  UserDefaults.swift
//  TrackMe
//
//  Created by Tamilarasu on 19/04/18.
//  Copyright © 2018 iTamilan. All rights reserved.
//

import Foundation
enum MapView: String {
    case appleMapView
    case googleMapView
}

fileprivate let mapViewKey = "MapViewKey"
extension UserDefaults {
    func getDefaultMapView() -> MapView {
        if let mapViewString = UserDefaults.standard.string(forKey: mapViewKey),
            let mapView = MapView.init(rawValue: mapViewString) {
            return mapView
        } else {
            return MapView.appleMapView
        }
    }
    
    func setDefaultMapView(_ defaultMapView: MapView) {
        let mapViewString = defaultMapView.rawValue
        UserDefaults.standard.set(mapViewString, forKey: mapViewKey)
        UserDefaults.standard.synchronize()
    }
}
