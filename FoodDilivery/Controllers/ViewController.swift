//
//  ViewController.swift
//  FoodDilivery
//
//  Created by Преподаватель on 29.11.2021.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController {
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 700
    var previousLocation: CLLocation?
    var locationCord: CLLocationCoordinate2D?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if locationCord == nil {
            setupLocationManager()
            checkLocationAuthorization()
        }else{
            let region = MKCoordinateRegion.init(center: locationCord!, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
            
            checkLocationAuthorization()
        }
    }
    
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    
    func checkLocationAuthorization() {
        startTackingUserLocation()
        mapView.showsUserLocation = true
        locationManager.startUpdatingLocation()
        if locationCord == nil {
            centerViewOnUserLocation()
        }
    }
    
    
    func startTackingUserLocation() {
        mapView.showsUserLocation = true
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }
    
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
}


extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}



extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
        
        guard let previousLocation = self.previousLocation else { return }
        self.previousLocation = center
        
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            
            if let _ = error {
                return
            }
            
            let streetNumber = (placemarks?.first?.subThoroughfare ?? "").replacingOccurrences(of: " ", with: "")
            let streetName: String = {
                var streetName = placemarks?.first?.thoroughfare ?? ""
                
                if streetNumber != "" && streetName != ""{
                    streetName += ","
                }
                
                return streetName
            }()
            
            let city: String = {
                var cites = placemarks?.first?.locality ?? ""
                
                if cites != "" && streetName != ""{
                    cites += ","
                }
                
                return cites
            }()
            
            DispatchQueue.main.async {
                self.addressLabel.text = "\(city) \(streetName) \(streetNumber)"
            }
        }
    }
}


