//
//  MapViewController.swift
//  TrackMe
//
//  Created by Tamilarasu on 19/04/18.
//  Copyright © 2018 iTamilan. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import GoogleMaps

let REGION_DIAMETER = 1000.0

class MapViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: private
    
    @IBOutlet private weak var googleMapView: GMSMapView!
    @IBOutlet private weak var appleMapView: MKMapView!
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    
    private var defaultMapView = UserDefaults.standard.getDefaultMapView() {
        didSet {
            enableDefaultMap()
        }
    }
    
    // MARK: public
    var location: CLLocation? {
        didSet {
            plotMap(location)
        }
    }
    
    // MARK: - View cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enableDefaultMap()
        configureSegmentControl()
        configureMaps()
    }
    
    // MARK: - Configure
    
    private func configureSegmentControl() {
        segmentControl.selectedSegmentIndex = defaultMapView == .appleMapView ? 0 : 1
    }
    
    private func configureMaps() {
        googleMapView.isMyLocationEnabled = true
        appleMapView.showsUserLocation = true
    }
    
    // MARK: - Actions
    
    @IBAction private func segmentValueChanged(_ sender: Any) {
        let appleMapSelected = segmentControl.selectedSegmentIndex == 0
        defaultMapView = appleMapSelected ? MapView.appleMapView : MapView.googleMapView
        UserDefaults.standard.setDefaultMapView(defaultMapView)
    }
    
    // MARK: - Load Default mapview
    private func enableDefaultMap() {
        if defaultMapView == MapView.appleMapView {
            enableAppleMap()
        } else {
            enalbeGoogleMap()
        }
    }
    
    private func enableAppleMap() {
        appleMapView.isHidden = false
        googleMapView.isHidden = true
    }
    
    private func enalbeGoogleMap() {
        appleMapView.isHidden = true
        googleMapView.isHidden = false
        
    }
    
    private func plotMap(_ plotLocation: CLLocation?) {
        if defaultMapView == MapView.appleMapView {
            plotAppleMap(plotLocation)
        } else {
            plotGoogleMap(plotLocation)
        }
    }
    
    private func plotAppleMap(_ plotLocation: CLLocation?) {
        
        appleMapView.removeAnnotations(appleMapView.annotations)
        
        if let location = plotLocation {
            
            //            let pin  = MKPointAnnotation()
            //            pin.coordinate = location.coordinate
            //            appleMapView.addAnnotation(pin)
            
            let mapRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, REGION_DIAMETER, REGION_DIAMETER)
            appleMapView.setRegion(mapRegion, animated: true)
        }
    }
    
    private func plotGoogleMap(_ plotLocation: CLLocation?) {
        if let location = plotLocation {
            let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                                  longitude: location.coordinate.longitude,
                                                  zoom: 15.0)
            googleMapView.camera = camera
            
//            let marker = GMSMarker()
//            marker.position = location.coordinate
//            marker.title = "Current"
//            marker.snippet = "Location"
//            marker.map = googleMapView
        }
    }
}
