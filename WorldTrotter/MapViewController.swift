//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Alex Louzao on 2/13/17. Last edit: 2-20-17
//  Copyright © 2017 ALcsc2310. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate{
    
    var mapView: MKMapView!
    var location: CLLocation!
    let locationManager = CLLocationManager()
    var pinPress:Int = 0

    
    override func viewDidLoad() {
        print("MapViewController loaded its view.")
    }
    
    override func loadView() {
        mapView = MKMapView()
        mapView.delegate = self
        view = mapView
        locationManager.requestAlwaysAuthorization()
        let margins = view.layoutMarginsGuide
        
        // Creating a button that will place a pin on the map
        // sets up constraints and location for the button so it can adjust 
        // to any device and stay in the location of the bottom of the app
        let pinButton = UIButton()
        pinButton.setTitle("Get Pins", for: .normal)
        pinButton.backgroundColor = UIColor.blue
        pinButton.tag = 1
        pinButton.addTarget(self, action: #selector(getPins(_ :)), for: .touchUpInside)
        view.addSubview(pinButton)
        pinButton.translatesAutoresizingMaskIntoConstraints = false
        pinButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -8).isActive = true
        pinButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        
        // Makes a button that will get the current location of the user
        // sets up constraints and location for the button so it can adjust
        // to any device and stay in the location of the bottom of the app
        let locButton = UIButton()
        locButton.setTitle("Get Location", for: .normal)
        locButton.backgroundColor = UIColor.blue
        locButton.addTarget(self, action: #selector(getUserLoc(_ :)), for: .touchUpInside)
        view.addSubview(locButton)
        locButton.translatesAutoresizingMaskIntoConstraints = false
        locButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -8).isActive = true
        locButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true

        // Sets up tabs that contain different views for the maps and sets the constraint
        // so that the bar is displayed at the top of the app
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
    
    // once the button to get the user location has been pressed, it will call
    // the function to locate, zoom, and display the user location
    func getUserLoc(_ sender: UIButton){
        print("Getting User Location")
        // Click once go to location
        mapView.showsUserLocation = true
        // clicked again zoom back out
        // Have the sender reset the image view
        sender.addTarget(self, action: #selector(reset), for: .touchUpInside)
    }
    
    // once the get location button is pressed again or the pin button has fully cycled through
    // it will reset the view of the map to return to its default view
    func reset(){
        if pinPress == 0{
            loadView()
        } else {
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
    }
    

    // gets the current user location by looking at their longitude and latitude
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
    
    // when the button is pressed, it will cycle to each predefined pin
    // it will increment the button tag to determine the order of the pins
    // after it has cycled through all pins, it will return to the default view
    // I use the button tag to keep track of the cycle and increment after each press
    func getPins(_ sender: UIButton){
        // have the button go through the pinned locations
        //print("Getting A Pin")
        pinPress = 1
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
            pinPress = 1
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
            pinPress = 1
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
            pinPress = 1
            break;
        case 4:
            // check if get location is already done so it wont reset
            pinPress = 1
            loadView()

            sender.tag = 1
        default: ()
            break;
        }
        
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
