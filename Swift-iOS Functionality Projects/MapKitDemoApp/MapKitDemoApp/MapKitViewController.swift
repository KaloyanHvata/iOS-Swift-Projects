//
//  MapKitViewController.swift
//  MapKitDemoApp
//
//  Created by Kaloyan Petrov on 12/2/15.
//  Copyright © 2015 kaloyanpetrov. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapKitViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    //Reference for Nadezhda-1 : 42.727401, 23.290717
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //User's location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization() //does not work in simulator
        
        locationManager.startUpdatingLocation()
        
        //Hvata's Home
        
        let latitude : CLLocationDegrees = 42.727401
        let longtitude : CLLocationDegrees =
        23.290717
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longtitude)
        
        //setting up the deltas for latitude and longtitude (how much zoom in-out)
        let latitudeDelta : CLLocationDegrees = 0.03
        let longtitudeDelta : CLLocationDegrees = 0.03
        
        //Seting up the span of the map
        let span : MKCoordinateSpan = MKCoordinateSpanMake(latitudeDelta, longtitudeDelta)
        
        //creating a region 
        let region : MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.setRegion(region, animated: true)
        
        //Setting up the Anotation for my home
        let homeHvata = MKPointAnnotation()
        homeHvata.coordinate = location
        homeHvata.title = "Hvata's Home!"
        map.addAnnotation(homeHvata)
        
        //Add gesture recognizer
        let longPress = UILongPressGestureRecognizer(target: self, action: "mapLongPress:")
        longPress.minimumPressDuration = 1.5
        map.addGestureRecognizer(longPress)
        
        
    }
    //Function called when gesture recognizer detects a long press
    
    func mapLongPress(recognizer: UIGestureRecognizer){
    
        let touchedAt = recognizer.locationInView(self.map)
        let touchedAtCoordinate : CLLocationCoordinate2D = map.convertPoint(touchedAt, toCoordinateFromView: self.map)
        let newPin = MKPointAnnotation()
        newPin.coordinate = touchedAtCoordinate
        map.addAnnotation(newPin)
       // print("A long press has been detected.")
    
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
     //   print(locations)
        let currentLocation : CLLocation = locations[0] as CLLocation
        
        let longtitude = currentLocation.coordinate.longitude
        let latitude = currentLocation.coordinate.latitude
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longtitude)
        
        let latitudeDelta : CLLocationDegrees = 0.03
        let longtitudeDelta : CLLocationDegrees = 0.03
        
        let span : MKCoordinateSpan = MKCoordinateSpanMake(latitudeDelta, longtitudeDelta)
        
        let region : MKCoordinateRegion = MKCoordinateRegionMake(location , span)
        
        self.map.setRegion(region, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
