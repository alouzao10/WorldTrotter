//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Alex Louzao on 1/25/17.
//  Copyright © 2017 ALcsc2310. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapViewController loaded its view.")

    }
    
    var mapView: MKMapView!
    override func loadView() {
        mapView = MKMapView()
        view = mapView
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConst = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
        
        let margins = view.layoutMarginsGuide
        let leadingConst = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConst = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConst.isActive = true
        leadingConst.isActive = true
        trailingConst.isActive = true
        
    }
    
    func mapTypeChanged(_ segControl: UISegmentedControl){
        switch segControl.selectedSegmentIndex{
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
}
