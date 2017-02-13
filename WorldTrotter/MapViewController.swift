//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Alex Louzao on 1/25/17.
//  Copyright © 2017 ALcsc2310. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    
    var mapView: MKMapView!
    var location: CLLocation!
    let locationManager = CLLocationManager()
    
    
    //self.mapView.delegate = self // where should this be in code -> loadView
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self // the instance of the view itself MapViewController
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        print("MapViewController loaded its view.")
    }
    
    override func loadView() {
        mapView = MKMapView()
        mapView.delegate = self
        view = mapView
        
        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid map view")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")
        let segmentedControl = UISegmentedControl(items: [standardString, hybridString, satelliteString])
        
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
    
    func mapViewWillStartLocatingUser(_ mapView: MKMapView) {
        print("Start Loc")
    }
    
    func mapViewDidStopLocatingUser(_ mapView: MKMapView) {
        print("Stop Loc")
    }
    
    @IBAction func getCurrLoc(sender: AnyObject){
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //let userLoc:CLLocation = locations[0]
        
        let latitude1:CLLocationDegrees = 40.7684
        let longitude1:CLLocationDegrees = -74.1454
        
        let latitude2:CLLocationDegrees = 35.9732
        let longitude2:CLLocationDegrees = -79.9950
        
        let latitude3:CLLocationDegrees = 43.7332
        let longitude3:CLLocationDegrees = -7.6740
        
        //let latDelta:CLLocationDegrees = 0.05
        //let longDelta:CLLocationDegrees = 0.05
        //let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        //let location1:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude1, longitude1)
        
        //let location2:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude2, longitude2)
        
        //let location3:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude3, longitude3)

        //let region1:MKCoordinateRegion = MKCoordinateRegionMake(location1, span)
        //let region2:MKCoordinateRegion = MKCoordinateRegionMake(location2, span)
        //let region3:MKCoordinateRegion = MKCoordinateRegionMake(location3, span)

        
        //mapView.setRegion(region1, animated: false)
        //mapView.setRegion(region2, animated: false)
        
        //let getLoc = UIButton(type: .detailDisclosure)
        //rightCalloutAccessoryView = getLoc
        
        let pin1 = MKPointAnnotation()
        let pin2 = MKPointAnnotation()
        let pin3 = MKPointAnnotation()
        pin1.coordinate.latitude = latitude1
        pin1.coordinate.longitude = longitude1
        pin2.coordinate.latitude = latitude2
        pin2.coordinate.longitude = longitude2
        pin3.coordinate.latitude = latitude3
        pin3.coordinate.longitude = longitude3
        pin1.title = "I Was Born Here"
        pin2.title = "I Am Here"
        pin3.title = "I Want To Be Here"
        mapView.addAnnotation(pin1)
        mapView.addAnnotation(pin2)
        mapView.addAnnotation(pin3)

    }
    
    func mapTypeChanged(_ segControl: UISegmentedControl){
        switch segControl.selectedSegmentIndex{
        case 0:
            mapView.mapType = .standard
            mapView.showsUserLocation = true
        case 1:
            mapView.mapType = .hybrid
            mapView.showsUserLocation = true
        case 2:
            mapView.mapType = .satellite
            mapView.showsUserLocation = true
        default:
            break
        }
    }
}
