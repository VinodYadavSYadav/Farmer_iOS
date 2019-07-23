//
//  MenuListTableViewCell.swift
//  Farmer
//
//  Created by Apple on 17/06/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit

class MenuListTableViewCell: UITableViewCell {

    @IBOutlet weak var menuNameLbl: UILabel!
    @IBOutlet weak var menuImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
