//
//  ViewController.swift
//  WeatherMapText
//
//  Created by  Arthur Bodrov on 03/07/2019.
//  Copyright © 2019  Arthur Bodrov. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, Delegate {
   
    @IBOutlet weak var mapView: MKMapView!
    
    var citiesId: [CityId] = [
        CityId(name: "Moscow", id: 524901),
        CityId(name: "Kaluga", id: 553915),
        CityId(name: "Tula", id: 480562),
        CityId(name: "Tver", id: 480060),
        CityId(name: "Obninsk", id: 516436),
        CityId(name: "Kolomna", id: 546230),
        CityId(name: "Kimry", id: 548652)
    ]
    
    var networkingService: NetworkingService!
    
    let initialLocation: CLLocation = CLLocation(latitude:  55.751244, longitude: 37.618423)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        zoomOnMap(initialLocation)
        makeStringFromId(WithArrayOfCities: citiesId)
        
        networkingService = NetworkingService()
        networkingService.delegate = self
        
        DispatchQueue.global(qos: .utility).async {
            
            self.networkingService.downloadForecast {
                self.createAnnotations(array: self.networkingService.cities)
            }
            
        }
    }

    func zoomOnMap(_ location: CLLocation) { 
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func makeStringFromId(WithArrayOfCities array: [CityId]) {
        if array.count > 0 {
            var idsOfCities: [String] = []
            for i in array {
                idsOfCities.append("\(i.id)")
                
            }
            
            Ids.intanceShared.ids = idsOfCities.joined(separator: ",")

        } else {
                   print("Array of ids cities is empty")
        }
 
    }
    
    func createAnnotations(array: [City]) {
        for city in array {
            let annotation = MKPointAnnotation()
            annotation.title = "\(city.name), \(city.temp)˚"
            annotation.coordinate = CLLocationCoordinate2D(latitude: city.latitude, longitude: city.longitude)
            mapView.addAnnotation(annotation)
        }
    }
    
    func passingValue() -> Int {
        return citiesId.count
    }
}

