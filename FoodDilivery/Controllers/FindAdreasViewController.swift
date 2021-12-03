//
//  FindAdreasViewController.swift
//  FoodDilivery
//
//  Created by Преподаватель on 01.12.2021.
//

import UIKit
import MapKit
import CoreLocation

class FindAdreasViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var mapArray: [MKMapItem] = []
    let locationManager = CLLocationManager()
    var cordinate: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
    }
    
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
        }
    }
    
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        case .denied:
            break
        case .notDetermined:
            break
        case .restricted:
            break
        case .authorizedAlways:
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
}

extension FindAdreasViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinates = locations.last?.coordinate else {
            return
        }
        cordinate = coordinates
        tableView.reloadData()
    }
}

extension FindAdreasViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cordinate != nil ? mapArray.count + 1 : mapArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var i = indexPath.row
        
        guard indexPath.row != 0 && cordinate != nil else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LoactionTableViewCell
            
            CLGeocoder().reverseGeocodeLocation(.init(latitude: cordinate!.latitude, longitude: cordinate!.longitude)) { placemak, error in
                if error == nil{
                    let streetNumber = (placemak?.first?.subThoroughfare ?? "").replacingOccurrences(of: " ", with: "")
                    let streetName: String = {
                        var streetName = placemak?.first?.thoroughfare ?? ""
                        
                        if streetNumber != "" && streetName != ""{
                            streetName += ","
                        }

                        return streetName
                    }()
                    
                    let city: String = {
                        var cites = placemak?.first?.locality ?? ""
                        
                        if cites != "" && streetName != ""{
                            cites += ","
                        }
                        
                        return cites
                    }()
                    cell.addreasLabel.text = "\(city) \(streetName) \(streetNumber)"
                }
            }
            return cell
        }
        
        if cordinate != nil{
            i -= 1
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        
        
        let streetNumber = (mapArray[i].placemark.subThoroughfare ?? "").replacingOccurrences(of: " ", with: "")
        let streetName: String = {
            var streetName = mapArray[i].placemark.thoroughfare ?? ""
            
            if streetNumber != "" && streetName != ""{
                streetName += ","
            }
            
            return streetName
        }()
        
        let city: String = {
            var cites = mapArray[i].placemark.locality ?? ""
            
            if cites != "" && streetName != ""{
                cites += ","
            }
            
            return cites
        }()
        
        
        cell.textLabel?.text = "\(city) \(streetName) \(streetNumber)"
        if cell.textLabel?.text?.replacingOccurrences(of: " ", with: "" ) == ""{
            cell.textLabel?.text = "Latitude - \(mapArray[i].placemark.coordinate.latitude), Longitude - \(mapArray[i].placemark.coordinate.longitude)"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "choose") as! ViewController
    
        if indexPath.row != 0{
            if cordinate != nil{
                vc.locationCord = mapArray[indexPath.row - 1].placemark.coordinate
            }else{
                vc.locationCord = mapArray[indexPath.row].placemark.coordinate
            }
        }
        
        show(vc, sender: nil)
    }
    
}

extension FindAdreasViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        guard let searchBarText = searchBar.text else { return }
        
        let request = MKLocalSearch.Request()
        
        request.naturalLanguageQuery = searchBarText
        if cordinate != nil{
            request.region = MKCoordinateRegion(center: cordinate!, latitudinalMeters: 100000, longitudinalMeters: 100000)
        }
    
        
        let search = MKLocalSearch(request: request)
        
        search.start { response, _ in
            guard let response = response else {
                return
            }
            
            self.mapArray = response.mapItems
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchBarText = searchBar.text else { return }
        
        let request = MKLocalSearch.Request()
        
        request.naturalLanguageQuery = searchBarText
        if cordinate != nil{
            request.region = MKCoordinateRegion(center: cordinate!, latitudinalMeters: 100000, longitudinalMeters: 100000)
        }
    
        
        let search = MKLocalSearch(request: request)
        
        search.start { response, _ in
            guard let response = response else {
                return
            }
            
            self.mapArray = response.mapItems
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
