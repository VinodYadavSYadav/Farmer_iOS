//
//  CurrentLocationVC.swift
//  Farmer
//
//  Created by Apple on 15/07/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import GoogleMaps

class CurrentLocationVC: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    @IBOutlet weak var gMapView: GMSMapView!
    @IBOutlet weak var completeView: UIView!
    @IBOutlet weak var locationNameLbl: UILabel!
    @IBOutlet weak var confirmLocationBtn: UIButton!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    static var currentLatitude = Double()
    static var currentLongitutde = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gMapView.delegate = self
        
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            currentLocation = locationManager.location
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }
        gMapView.isMyLocationEnabled = true
        gMapView.settings.myLocationButton = true
        
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.startUpdatingLocation()
        guard let location = locations.first else {
            return
        }
        
        gMapView.camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom:6)
        print("printing lat and long",  location.coordinate.latitude, location.coordinate.longitude)
        
        CurrentLocationVC.currentLatitude = Double(location.coordinate.latitude)
        CurrentLocationVC.currentLongitutde = Double(location.coordinate.longitude)
        
        print("printing lat and long",  CurrentLocationVC.currentLatitude,  CurrentLocationVC.currentLongitutde)
        
        //Creates a marker in the center of the map.
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                marker.map = gMapView
                print("printing lat and long",  location.coordinate.latitude, location.coordinate.longitude)
        
        locationManager.stopUpdatingLocation()
    }
    
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            self.locationNameLbl.text = lines.joined(separator: "\n")
            
            
            
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
//        func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
//
//            let destinationMarker = GMSMarker()
//            destinationMarker.position = position.target
//            destinationMarker.map = gMapView
//            print("mmmmmmmmmmmmmmm",destinationMarker.position)
//        }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinate(position.target)
    }
    @IBAction func closeBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)

//    self.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)

    }
    
}
