//
//  HomeViewController.swift
//  TrackMe
//
//  Created by Tamilarasu on 14/04/18.
//  Copyright © 2018 iTamilan. All rights reserved.
//

import Foundation
import UIKit
import MapKit


class HomeViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    private lazy var mapViewController: MapViewController = {
        for viewController in self.childViewControllers {
            if let mapViewController = viewController as? MapViewController {
                return mapViewController
            }
        }
        return MapViewController()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManager.shared.addDelegate(self)
//        mapViewController.location = .none
    }
}

extension HomeViewController: LocationManagerDelegate {
    func didUpdate(location: CLLocation) {
        
        CoreDataManager.add([location])
        mapViewController.location = location
    }
}
