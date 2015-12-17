//
//  DetailViewController.swift
//  belly_cc
//
//  Created by Ben Fallon on 12/16/15.
//  Copyright © 2015 Ben Fallon. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DetailViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var locationDistance: UILabel!
    @IBOutlet weak var locationType: UILabel!
    
    var nameOfLocation: String?
    var distanceToLocation: Double?
    var typeOfLocation: String?
    var locationLat: Double?
    var locationLong: Double?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationName.text = nameOfLocation
        locationDistance.text = String("\(distanceToLocation!) miles away")
        locationType.text = typeOfLocation!
        
        setupMap()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setupMap(){
        let location = CLLocationCoordinate2D(latitude: locationLat!, longitude: locationLong!)
        let span = MKCoordinateSpanMake(0.005, 0.005)
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
       
        mapView.addAnnotation(annotation)

    }

}
