//
//  MapViewController.swift
//  WeatherApp
//
//  Created by Dulce Itamar Vigueras Ballesteros on 21/01/25.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    let mapView : MKMapView = {
        let map = MKMapView()
        map.overrideUserInterfaceStyle = .dark
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setMapConstraints()
        // Do any additional setup after loading the view.
    }
    

    func setMapConstraints(){
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }

}

extension MapViewController: MKMapViewDelegate {
    
}
