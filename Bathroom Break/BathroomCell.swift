//
//  BathroomCell.swift
//  Bathroom Break
//
//  Created by Christopher Dabalsa on 4/29/19.
//  Copyright © 2019 Team Notify. All rights reserved.
//

import UIKit

class BathroomCell: UITableViewCell {
    
    @IBOutlet weak var bathroomImage: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var overallRatingLabel: UILabel!
    @IBOutlet weak var numberOfReviewsLabel: UILabel!
    @IBOutlet weak var bathroomIDLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
