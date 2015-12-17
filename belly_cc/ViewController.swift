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
    
        print("Hello from viewDidLoad")
        setUpLocations()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        locationTableView.reloadData()
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
//        let myLocation = Location(name: "Place", lat: 22, long: 43, category: "Food", imageUrl: "http://nuclearpixel.com/content/icons/2010-02-09_stellar_icons_from_space_from_2005/earth_128.png")
//        arrayOfLocations.append(myLocation)
        let userLat = locationManager.location?.coordinate.latitude
        let userLong = locationManager.location?.coordinate.longitude
    
        print(userLong)
        print(userLat)
        Alamofire.request(.GET, "https://api.foursquare.com/v2/venues/search?ll=\(userLat!),\(userLong!)&client_id=\(clientID)&client_secret=\(clientSecret)&v=\(currentDate())").responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    print(value)
                    let json = JSON(value)
                    let locationsArray = json["response"]["venues"].arrayValue
                    for var i = 0; i < locationsArray.count;{
                        let locationName = locationsArray[i]["name"].stringValue
                        let locationLat = locationsArray[i]["location"]["lat"].stringValue
                        let locationLong = locationsArray[i]["location"]["lng"].stringValue
                        let locationCat = locationsArray[i]["categories"][0]["name"].stringValue
                        let locationImageUrlPrefix = locationsArray[i]["categories"][0]["icon"]["prefix"].stringValue
                        let locationImageUrlSuffix = locationsArray[i]["categories"][0]["icon"]["suffix"].stringValue
                        let newLocation = Location(name: locationName, lat: Double(locationLat)!, long: Double(locationLong)!, category: locationCat, imageUrlPrefix: locationImageUrlPrefix, imageUrlSuffix: locationImageUrlSuffix)
                        self.addLocationToList(newLocation)
                        print("Hello from the JSON")
                        i++
                    }

                    
                }
            case .Failure:
                print("failure")
                
            }
        }
        print(arrayOfLocations)
        [locationTableView.reloadData()]
    }
    
    func addLocationToList(locationToAdd: Location){
        arrayOfLocations.append(locationToAdd)
        print(arrayOfLocations)
        [locationTableView.reloadData()]
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayOfLocations.count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: LocationCell = locationTableView.dequeueReusableCellWithIdentifier("locationCell") as! LocationCell

        let locationToDipslay = arrayOfLocations[indexPath.row]
        cell.setCell(locationToDipslay.name, imageOfLocationPre: locationToDipslay.imageUrlPrefix, imageOfLocationSuf: locationToDipslay.imageUrlSuffix, categoryOfLocation: locationToDipslay.category)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let location = self.arrayOfLocations[indexPath.row]
        
        var detailedViewController: DetailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        
        self.presentViewController(detailedViewController, animated: true, completion: nil)
    }


}

