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
    
    //Reference Vitoshka : 42.687052, 23.318864
    //Reference Nadejda 1 : 42.727394, 23.290561
    @IBOutlet weak var myMap: MKMapView!
    var myRoute : MKRoute?
    var currentPosition = MKPointAnnotation()
    var home = MKPointAnnotation()
    let locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Users location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
       // locationManager.requestAlwaysAuthorization() //not a good way for deployment
        locationManager.requestWhenInUseAuthorization() //does not work in simulator
        
        locationManager.startUpdatingLocation()

    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        
        var myLineRenderer = MKPolylineRenderer(polyline: (myRoute?.polyline)!)
        myLineRenderer.strokeColor = UIColor.redColor()
        myLineRenderer.lineWidth = 3
        return myLineRenderer
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
            //   print(locations)
        let currentLocation : CLLocation = locations[0] as CLLocation
        
        let longtitude = currentLocation.coordinate.longitude
        let latitude = currentLocation.coordinate.latitude
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longtitude)
        
//        let latitudeDelta : CLLocationDegrees = 0.03
//        let longtitudeDelta : CLLocationDegrees = 0.03
//        
//        let span : MKCoordinateSpan = MKCoordinateSpanMake(latitudeDelta, longtitudeDelta)
//        
//        let region : MKCoordinateRegion = MKCoordinateRegionMake(location , span)
//        
      //  self.myMap.setRegion(region, animated: true)
        
   
            //  currentPosition.coordinate = location
            myMap.addAnnotation(currentPosition)
            currentPosition.coordinate = location
            currentPosition.title = "Current Position"
            currentPosition.subtitle = "This is you!"
        
        
        home.coordinate = CLLocationCoordinate2DMake(42.727394, 23.290561)
        home.title = "Home!"
        myMap.addAnnotation(home)
        myMap.centerCoordinate = home.coordinate
        myMap.delegate = self
        
        //Span of the map
        myMap.setRegion(MKCoordinateRegionMake(home.coordinate, MKCoordinateSpanMake(0.03,0.03)), animated: true)
        
        //Directions
        var directionsRequest = MKDirectionsRequest()
        let currPlace = MKPlacemark(coordinate: CLLocationCoordinate2DMake(currentPosition.coordinate.latitude, currentPosition.coordinate.longitude), addressDictionary: nil)
        let homePlace = MKPlacemark(coordinate: CLLocationCoordinate2DMake(home.coordinate.latitude, home.coordinate.longitude), addressDictionary: nil)
        
        directionsRequest.source = MKMapItem(placemark: currPlace)
        directionsRequest.destination = MKMapItem(placemark:homePlace)
        directionsRequest.transportType = MKDirectionsTransportType.Automobile
        var directions = MKDirections(request: directionsRequest)
        directions.calculateDirectionsWithCompletionHandler{
            response, error in
            
            guard let response = response else {
                //handle the error here
                print(error)
                return
            }
            self.myRoute = response.routes[0] as? MKRoute
            self.myMap.addOverlay((self.myRoute?.polyline)!)
            
        }


    }
        func mapLongPress(recognizer: UIGestureRecognizer){
    
            let touchedAt = recognizer.locationInView(self.myMap)
            let touchedAtCoordinate : CLLocationCoordinate2D = myMap.convertPoint(touchedAt, toCoordinateFromView: self.myMap)
            let newPin = MKPointAnnotation()
            newPin.coordinate = touchedAtCoordinate
            myMap.addAnnotation(newPin)
           // print("A long press has been detected.")
        
        }

}



