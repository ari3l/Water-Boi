//
//  ComplaintTableViewCell.swift
//  Water Boi
//
//  Created by Ariel Steinlauf on 4/11/18.
//  Copyright © 2018 Ariels Apps LLC. All rights reserved.
//

import UIKit

class ComplaintTableViewCell: UITableViewCell {

    @IBOutlet weak var complaintTitleLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }    
}
