//
//  SettingsTableViewCell.swift
//  Farmer
//
//  Created by Apple on 17/06/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageOfSettingList: UIImageView!
    @IBOutlet weak var optionsNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
