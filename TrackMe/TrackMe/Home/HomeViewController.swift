//
//  HomeViewController.swift
//  TrackMe
//
//  Created by Tamilarasu on 14/04/18.
//  Copyright © 2018 Itamilan. All rights reserved.
//

import Foundation
import UIKit
import MapKit

let REGION_DIAMETER = 1000.0

class HomeViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManager.shared.addDelegate(self)
    }
}

extension HomeViewController: LocationManagerDelegate {
    func didUpdate(location: CLLocation) {
        let pin  = MKPointAnnotation()
        pin.coordinate = location.coordinate
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(pin)
        
        let mapRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, REGION_DIAMETER, REGION_DIAMETER)
        
        mapView.setRegion(mapRegion, animated: true)
    }
}
