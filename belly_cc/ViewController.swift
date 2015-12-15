//
//  ViewController.swift
//  belly_cc
//
//  Created by Ben Fallon on 12/15/15.
//  Copyright © 2015 Ben Fallon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var locationTableView: UIView!
    var arrayOfLocations = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpLocations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setUpLocations(){
        var location1 = Location(name: "Bill's Steakhouse", lat: 41.810446, long: -87.892233, category: "Food/Dining", imageUrl: "http://www.joomlaworks.net/images/demos/galleries/abstract/7.jpgs")
        var location2 = Location(name: "Starbucks", lat: 41.808430, long: -87.902253, category: "Coffee", imageUrl: "https://upload.wikimedia.org/wikipedia/en/thumb/3/35/Starbucks_Coffee_Logo.svg/1024px-Starbucks_Coffee_Logo.svg.png")
        
        arrayOfLocations.append(location1)
        arrayOfLocations.append(location2)
    }

}

