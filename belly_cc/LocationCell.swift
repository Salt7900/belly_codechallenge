//
//  LocationCell.swift
//  belly_cc
//
//  Created by Ben Fallon on 12/15/15.
//  Copyright © 2015 Ben Fallon. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {


    @IBOutlet weak var locationPicture: UIImageView!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var locationDistance: UILabel!
    @IBOutlet weak var locationCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(nameOfLocation: String, imageOfLocationPre: String, imageOfLocationSuf: String,categoryOfLocation: String, distanceTo: Int){
        let totalImageUrl = "\(imageOfLocationPre)bg_88\(imageOfLocationSuf)"
        if let url = NSURL(string: totalImageUrl) {
            if let data = NSData(contentsOfURL: url) {
                locationPicture.image = UIImage(data: data)
            }        
        }
        
        self.locationDistance.text = String("\(distanceTo) meters away")
        self.locationName.text = nameOfLocation
        self.locationCategory.text = categoryOfLocation
    }

}
