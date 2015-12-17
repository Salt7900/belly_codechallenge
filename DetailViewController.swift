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
    var distanceToLocation: Int?
    var typeOfLocation: String?
    var locationLat: Double?
    var locationLong: Double?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationName.text = nameOfLocation
        locationDistance.text = String(distanceToLocation!)
        locationType.text = typeOfLocation!
        
        setupMap()
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setupMap(){
        var location = CLLocationCoordinate2D(latitude: locationLat!, longitude: locationLong!)
        var span = MKCoordinateSpanMake(0.25, 0.25)
        var region = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
        
        var annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = nameOfLocation
        annotation.subtitle = "\(String(typeOfLocation)) m away"
        
        mapView.addAnnotation(annotation)

    }

}
