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
import SwiftyJSON
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    let clientID = FSClientDetails().clientID()
    let clientSecret = FSClientDetails().clientSecret()
    
    var locationManager = CLLocationManager()

    
    @IBOutlet weak var locationTableView: UITableView!
    var arrayOfLocations = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
    
        setUpLocations()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func currentDate() -> String{
        let date = NSDate();
        var formatter = NSDateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter.stringFromDate(date);
    }
    

    func setUpLocations(){
        let userLat = locationManager.location?.coordinate.latitude
        let userLong = locationManager.location?.coordinate.longitude
    
        Alamofire.request(.GET, "https://api.foursquare.com/v2/venues/search?ll=\(userLat!),\(userLong!)&client_id=\(clientID)&client_secret=\(clientSecret)&v=\(currentDate())").responseJSON { response in
            
            print(response.request)
            print(response.response)

        }

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

