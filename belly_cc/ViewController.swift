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
    let userDefaults = NSUserDefaults.standardUserDefaults()


    @IBOutlet weak var locationTableView: UITableView!
    var arrayOfLocations : [Location] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()

        setUpLocations()

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

        if connectedToNetwork(){
            if userLat != nil{
                Alamofire.request(.GET, "https://api.foursquare.com/v2/venues/search?ll=\(userLat!),\(userLong!)&client_id=\(clientID)&client_secret=\(clientSecret)&v=\(currentDate())").responseJSON { response in
                    switch response.result {
                    case .Success:
                        if let value = response.result.value {
                            let json = JSON(value)
                            let jsonAsString = String(json)
                            self.userDefaults.setValue(jsonAsString, forKey: "cachedJson")
                            let locationsArray = json["response"]["venues"].arrayValue
                            for var i = 0; i < locationsArray.count;{
                                let locationName = locationsArray[i]["name"].stringValue
                                let locationLat = locationsArray[i]["location"]["lat"].stringValue
                                let locationLong = locationsArray[i]["location"]["lng"].stringValue
                                let locationDistance = locationsArray[i]["location"]["distance"].stringValue
                                let locationCat = locationsArray[i]["categories"][0]["name"].stringValue
                                let locationImageUrlPrefix = locationsArray[i]["categories"][0]["icon"]["prefix"].stringValue
                                let locationImageUrlSuffix = locationsArray[i]["categories"][0]["icon"]["suffix"].stringValue
                                let newLocation = Location(name: locationName, lat: Double(locationLat)!, long: Double(locationLong)!, category: locationCat, imageUrlPrefix: locationImageUrlPrefix, imageUrlSuffix: locationImageUrlSuffix, distanceTo: Int(locationDistance)! )
                                self.addLocationToList(newLocation)
                                i++
                            }
                        }

                    case .Failure:
                        print("failure")

                    }
                }
            }else{
                sleep(4)
                print("Hello from else")
                setUpLocations()
            }

        }else{
          let jsonToParse = userDefaults.objectForKey("cachedJson")!
          let json = JSON(jsonToParse)
            let jsonAsString = String(json)
            self.userDefaults.setValue(jsonAsString, forKey: "cachedJson")
            let locationsArray = json["response"]["venues"].arrayValue
            for var i = 0; i < locationsArray.count;{
                let locationName = locationsArray[i]["name"].stringValue
                let locationLat = locationsArray[i]["location"]["lat"].stringValue
                let locationLong = locationsArray[i]["location"]["lng"].stringValue
                let locationDistance = locationsArray[i]["location"]["distance"].stringValue
                let locationCat = locationsArray[i]["categories"][0]["name"].stringValue
                let locationImageUrlPrefix = locationsArray[i]["categories"][0]["icon"]["prefix"].stringValue
                let locationImageUrlSuffix = locationsArray[i]["categories"][0]["icon"]["suffix"].stringValue
                let newLocation = Location(name: locationName, lat: Double(locationLat)!, long: Double(locationLong)!, category: locationCat, imageUrlPrefix: locationImageUrlPrefix, imageUrlSuffix: locationImageUrlSuffix, distanceTo: Int(locationDistance)! )
                self.addLocationToList(newLocation)
                i++
            }


        }
    }

    func addLocationToList(locationToAdd: Location){
        arrayOfLocations.append(locationToAdd)
        arrayOfLocations.sortInPlace {(loc1:Location, loc2:Location) -> Bool in
            loc1.distanceTo < loc2.distanceTo}
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
        cell.setCell(locationToDipslay.name, imageOfLocationPre: locationToDipslay.imageUrlPrefix, imageOfLocationSuf: locationToDipslay.imageUrlSuffix, categoryOfLocation: locationToDipslay.category, distanceTo: locationToDipslay.distanceInMiles())

        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let location = self.arrayOfLocations[indexPath.row]

        var detailedViewController: DetailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController

        detailedViewController.nameOfLocation = location.name
        detailedViewController.distanceToLocation = location.distanceInMiles()
        detailedViewController.typeOfLocation = location.category
        detailedViewController.locationLong = location.long
        detailedViewController.locationLat = location.lat

        self.presentViewController(detailedViewController, animated: true, completion: nil)
    }


}
