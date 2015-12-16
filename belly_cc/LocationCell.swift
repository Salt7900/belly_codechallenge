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
    
    func setCell(nameOfLocation: String, imageOfLocation: String, categoryOfLocation: String){
        let url = NSURL(string: imageOfLocation)
        let data = NSData(contentsOfURL: url!)
        self.locationPicture.image = UIImage(data: data!)
        
        self.locationName.text = nameOfLocation
        self.locationCategory.text = categoryOfLocation
    }

}
