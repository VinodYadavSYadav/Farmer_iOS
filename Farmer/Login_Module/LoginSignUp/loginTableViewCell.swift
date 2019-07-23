//
//  DDTableViewCell.swift
//  Xohri
//
//  Created by Apple on 12/02/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit

class loginTableViewCell: UITableViewCell {
    @IBOutlet weak var loginCountryCodeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
