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

    @IBOutlet weak var myMap: MKMapView!
    var myRoute : MKRoute?
    var currentPosition = MKPointAnnotation()
    var point2 = MKPointAnnotation()
    let locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Users location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
       // locationManager.requestAlwaysAuthorization() //not a good way for deployment
        locationManager.requestWhenInUseAuthorization() //does not work in simulator
        
        locationManager.startUpdatingLocation()

        currentPosition.coordinate = CLLocationCoordinate2DMake(42.727401, 23.290717)
        currentPosition.title = "Current Position"
        currentPosition.subtitle = "This is you!"
        
        
        point2.coordinate = CLLocationCoordinate2DMake(42.687532, 23.320399)
        point2.title = "National Palace of Colture"
        myMap.addAnnotation(point2)
        myMap.centerCoordinate = point2.coordinate
        myMap.delegate = self
        
        //Span of the map
        myMap.setRegion(MKCoordinateRegionMake(point2.coordinate, MKCoordinateSpanMake(0.7,0.7)), animated: true)
        
        //Directions
        var directionsRequest = MKDirectionsRequest()
        let currPlace = MKPlacemark(coordinate: CLLocationCoordinate2DMake(currentPosition.coordinate.latitude, currentPosition.coordinate.longitude), addressDictionary: nil)
        let ndkDestionation = MKPlacemark(coordinate: CLLocationCoordinate2DMake(point2.coordinate.latitude, point2.coordinate.longitude), addressDictionary: nil)
        
        directionsRequest.source = MKMapItem(placemark: currPlace)
        directionsRequest.destination = MKMapItem(placemark: ndkDestionation)
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
        
                let latitudeDelta : CLLocationDegrees = 0.03
                let longtitudeDelta : CLLocationDegrees = 0.03
        
                let span : MKCoordinateSpan = MKCoordinateSpanMake(latitudeDelta, longtitudeDelta)
        
                let region : MKCoordinateRegion = MKCoordinateRegionMake(location , span)
        
                self.myMap.setRegion(region, animated: true)
                
              //  currentPosition.coordinate = location
                myMap.addAnnotation(currentPosition)

    }
}



//    var homeHvata = MKPointAnnotation()
//    var currentPosition = MKPointAnnotation()
//    //Route
//    var myRoute : MKRoute?
//    
//    let locationManager = CLLocationManager()
//    //Reference for Nadezhda-1 : 42.727401, 23.290717
//    //Regerence for NDK : 42.687532, 23.320399
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        
//        //User's location
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        //locationManager.requestAlwaysAuthorization()
//        locationManager.requestWhenInUseAuthorization() //does not work in simulator
//        
//        locationManager.startUpdatingLocation()
//        
//        //NDK
//        
//        let latitude : CLLocationDegrees = 42.687532
//        let longtitude : CLLocationDegrees =
//        23.320399
//        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longtitude)
//        
//        //setting up the deltas for latitude and longtitude (how much zoom in-out)
//        let latitudeDelta : CLLocationDegrees = 0.03
//        let longtitudeDelta : CLLocationDegrees = 0.03
//        
//        //Seting up the span of the map
//        let span : MKCoordinateSpan = MKCoordinateSpanMake(latitudeDelta, longtitudeDelta)
//        
//        //creating a region 
//        let region : MKCoordinateRegion = MKCoordinateRegionMake(location, span)
//        
//        map.setRegion(region, animated: true)
//        
//        //Setting up the Anotation for NDK ...later change for my home
//        homeHvata.coordinate = location
//        homeHvata.title = "Hvata's Home!"
//        map.addAnnotation(homeHvata)
//        
//        //Add gesture recognizer
//        let longPress = UILongPressGestureRecognizer(target: self, action: "mapLongPress:")
//        longPress.minimumPressDuration = 1.5
//        map.addGestureRecognizer(longPress)
//        
//        
//           }
//    
//    
//    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
//        
//        let myLineRenderer = MKPolylineRenderer(polyline: (myRoute?.polyline)!)
//        myLineRenderer.strokeColor = UIColor.redColor()
//        myLineRenderer.lineWidth = 3
//        return myLineRenderer
//    }
//
//    //Function called when gesture recognizer detects a long press
//    
//    func mapLongPress(recognizer: UIGestureRecognizer){
//    
//        let touchedAt = recognizer.locationInView(self.map)
//        let touchedAtCoordinate : CLLocationCoordinate2D = map.convertPoint(touchedAt, toCoordinateFromView: self.map)
//        let newPin = MKPointAnnotation()
//        newPin.coordinate = touchedAtCoordinate
//        map.addAnnotation(newPin)
//       // print("A long press has been detected.")
//    
//    }
//    
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        
//        
//     //   print(locations)
//        let currentLocation : CLLocation = locations[0] as CLLocation
//        
//        let longtitude = currentLocation.coordinate.longitude
//        let latitude = currentLocation.coordinate.latitude
//        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longtitude)
//        
//        let latitudeDelta : CLLocationDegrees = 0.03
//        let longtitudeDelta : CLLocationDegrees = 0.03
//        
//        let span : MKCoordinateSpan = MKCoordinateSpanMake(latitudeDelta, longtitudeDelta)
//        
//        let region : MKCoordinateRegion = MKCoordinateRegionMake(location , span)
//        
//        self.map.setRegion(region, animated: true)
//        
//        currentPosition.coordinate = location
//        map.addAnnotation(currentPosition)
//        
//        //Drawing a route
//        let directionsRequest = MKDirectionsRequest()
//        let destinationSource = MKPlacemark(coordinate: CLLocationCoordinate2DMake(homeHvata.coordinate.latitude, homeHvata.coordinate.longitude), addressDictionary: nil)
//        let currentSource = MKPlacemark(coordinate: CLLocationCoordinate2DMake(currentPosition.coordinate.latitude, currentPosition.coordinate.longitude), addressDictionary: nil)
//        
//        directionsRequest.source = MKMapItem(placemark: currentSource)
//        directionsRequest.destination = MKMapItem(placemark: destinationSource)
//        directionsRequest.transportType = MKDirectionsTransportType.Automobile
//        let directions = MKDirections(request: directionsRequest)
//        
//        directions.calculateDirectionsWithCompletionHandler{
//            response, error in
//            
//            guard let response = response else {
//                //handle the error here
//                print(error)
//                return
//            }
//            self.myRoute = response.routes[0] as? MKRoute
//            self.map.addOverlay((self.myRoute?.polyline)!)
//            
//        }
//
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//
//    
//}
