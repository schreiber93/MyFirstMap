//
//  ViewController.swift
//  MyFirstMap
//
//  Created by Kasey Schreiber on 5/28/16.
//  Copyright © 2016 Rock Valley College. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    @IBOutlet weak var navbar: UINavigationBar!
    @IBOutlet weak var mapview: MKMapView!

    private var locationManager = CLLocationManager()
    
    let initialRadius:CLLocationDistance = 5000
    
    var myloc:CLLocation = CLLocation()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        centerMapOnLocation(myloc)
        
        checkLocationAuthorizationStatus()
        
        mapview.delegate = self
        
        mapview.showsUserLocation = true
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapview.setRegion(region, animated: true)
    }
    
    //8 Needed to update location when user moves
    
    func mapView(mapView: MKMapView, didUpdateUserLocation
        userLocation: MKUserLocation) {
            mapView.centerCoordinate = userLocation.location!.coordinate
    }
    //9 Confirm user gives access to location
    
    //MARK: Setup Methods
    
    //Check the location Authorization
    
    func checkLocationAuthorizationStatus() {
        
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            
            mapview.showsUserLocation = true
            
        } else {
            
            locationManager.requestWhenInUseAuthorization()
        }
    }
    //Center the map onto a particular location.
    
    func centerMapOnLocation(location:CLLocation){
        
        let coordinateRegion:MKCoordinateRegion! = MKCoordinateRegionMakeWithDistance(location.coordinate, initialRadius * 2.0, initialRadius * 2.0)
        
        mapview.setRegion(coordinateRegion, animated: true)
        
    }
}

