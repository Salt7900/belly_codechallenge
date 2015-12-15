//
//  Location.swift
//  belly_cc
//
//  Created by Ben Fallon on 12/15/15.
//  Copyright © 2015 Ben Fallon. All rights reserved.
//

import Foundation

class Location {
    var name:String
    var lat:Double
    var long:Double
    var category:String
    var imageUrl:String

    init(name: String, lat: Double, long:Double, category:String, imageUrl: String){
        self.name = name;
        self.lat = lat;
        self.long = long;
        self.category = category;
        self.imageUrl = imageUrl
    }
}