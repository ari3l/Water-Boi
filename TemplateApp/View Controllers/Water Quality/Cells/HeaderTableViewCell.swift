//
//  HeaderTableViewCell.swift
//  Water Boi
//
//  Created by Ariel Steinlauf on 4/11/18.
//  Copyright © 2018 Ariels Apps LLC. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var complaintsNearbyLabel: UILabel!
    @IBOutlet weak var mostRecentComplaintLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
