//
//  ViewController.swift
//  belly_cc
//
//  Created by Ben Fallon on 12/15/15.
//  Copyright © 2015 Ben Fallon. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()

    
    @IBOutlet weak var locationTableView: UITableView!
    var arrayOfLocations = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        
        setUpLocations()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setUpLocations(){
        

    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayOfLocations.count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: LocationCell = locationTableView.dequeueReusableCellWithIdentifier("locationCell") as! LocationCell
        
        let locationToDipslay = arrayOfLocations[indexPath.row]
        cell.setCell(locationToDipslay.name, imageOfLocation: locationToDipslay.imageUrl, categoryOfLocation: locationToDipslay.category)
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let location = arrayOfLocations[indexPath.row]
        
        var detailedViewController: DetailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        
        self.presentViewController(detailedViewController, animated: true, completion: nil)
    }

}

