//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Alex Louzao on 2/13/17.
//  Copyright © 2017 ALcsc2310. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate{
    
    var mapView: MKMapView!
    var location: CLLocation!
    let locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        print("MapViewController loaded its view.")
    }
    
    override func loadView() {
        mapView = MKMapView()
        mapView.delegate = self
        view = mapView
        locationManager.requestAlwaysAuthorization()
        let margins = view.layoutMarginsGuide
        
        //let pinButton: UIButton = UIButton(frame: CGRect(x:250, y:100, width: 100, height: 50))
        let pinButton = UIButton()
        pinButton.setTitle("Get Pins", for: .normal)
        pinButton.backgroundColor = UIColor.blue
        pinButton.tag = 1
        pinButton.addTarget(self, action: #selector(getPins(_ :)), for: .touchUpInside)
        view.addSubview(pinButton)
        pinButton.translatesAutoresizingMaskIntoConstraints = false
        pinButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -8).isActive = true
        pinButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        //let locButton: UIButton = UIButton(frame: CGRect(x:16, y:100, width: 150, height: 50))
        let locButton: UIButton = UIButton()
        locButton.setTitle("Get Location", for: .normal)
        locButton.backgroundColor = UIColor.blue
        locButton.addTarget(self, action: #selector(getUserLoc(_ :)), for: .touchUpInside)
        view.addSubview(locButton)
        locButton.translatesAutoresizingMaskIntoConstraints = false
        locButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -8).isActive = true
        locButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true

        
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
    
    func getUserLoc(_ sender: UIButton){
        print("Getting User Location")
        // Click once go to location
        mapView.showsUserLocation = true
        // clicked again zoom back out
        // Have the sender reset the image view
        sender.addTarget(self, action: #selector(reset), for: .touchUpInside)
    }
    
    func reset(){
        loadView()
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation){
        //print("Getting User Location")
        let lat = mapView.userLocation.coordinate.latitude
        let long = mapView.userLocation.coordinate.longitude
        print("Lat = \(lat) and Long = \(long) of User")
        let latDelta:CLLocationDegrees = 0.05
        let longDelta:CLLocationDegrees = 0.05
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        mapView.setRegion(region, animated: true)

    }
    
    func getPins(_ sender: UIButton){
        // have the button go through the pinned locations
        //print("Getting A Pin")
        
        switch sender.tag{
        case 1:
            let lat:CLLocationDegrees = 40.7684
            let long:CLLocationDegrees = -74.1454
            let latDelta:CLLocationDegrees = 0.05
            let longDelta:CLLocationDegrees = 0.05
            let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
            let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
            let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            
            mapView.setRegion(region, animated: true)

            let pin1 = MKPointAnnotation()
            pin1.coordinate.latitude = lat
            pin1.coordinate.longitude = long
            pin1.title = "I Was Born Here"
            mapView.addAnnotation(pin1)
            sender.tag += 1
            print(sender.tag)
            break;
        case 2:
            let lat:CLLocationDegrees = 35.9732
            let long:CLLocationDegrees = -79.9950
            let latDelta:CLLocationDegrees = 0.05
            let longDelta:CLLocationDegrees = 0.05
            let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
            let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
            let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            
            mapView.setRegion(region, animated: true)
            
            let pin2 = MKPointAnnotation()
            pin2.coordinate.latitude = lat
            pin2.coordinate.longitude = long
            pin2.title = "I Am Here"
            mapView.addAnnotation(pin2)
            sender.tag += 1
            print(sender.tag)
            break;
        case 3:
            let lat:CLLocationDegrees = 43.7332
            let long:CLLocationDegrees = -7.6740
            let latDelta:CLLocationDegrees = 0.05
            let longDelta:CLLocationDegrees = 0.05
            let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
            let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
            let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            
            mapView.setRegion(region, animated: true)
           
            let pin3 = MKPointAnnotation()
            pin3.coordinate.latitude = lat
            pin3.coordinate.longitude = long
            pin3.title = "I Want To Be Here"
            mapView.addAnnotation(pin3)
            sender.tag += 1
            break;
        case 4:
            mapView.showsUserLocation = true
            sender.tag = 1
        default: ()
            break;
        }
        
    }
    
    /*func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
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

    }*/
    
    func mapTypeChanged(_ segControl: UISegmentedControl){
        switch segControl.selectedSegmentIndex{
        case 0:
            mapView.mapType = .standard
            //mapView.showsUserLocation = true
        case 1:
            mapView.mapType = .hybrid
            //mapView.showsUserLocation = true
        case 2:
            mapView.mapType = .satellite
            //mapView.showsUserLocation = true
        default:
            break
        }
    }
}
