//
//  Location.swift
//  belly_cc
//
//  Created by Ben Fallon on 12/15/15.
//  Copyright © 2015 Ben Fallon. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class Location {
    var name:String
    var lat:Double
    var long:Double
    var category:String
    var imageUrlPrefix:String
    var imageUrlSuffix:String
    var distanceTo:Int
    
    let locationManager = CLLocationManager()

    init(name: String, lat: Double, long:Double, category:String, imageUrlPrefix: String, imageUrlSuffix: String, distanceTo: Int){
        self.name = name;
        self.lat = lat;
        self.long = long;
        self.category = category;
        self.imageUrlPrefix = imageUrlPrefix;
        self.imageUrlSuffix = imageUrlSuffix;
        self.distanceTo = distanceTo;
    }

}