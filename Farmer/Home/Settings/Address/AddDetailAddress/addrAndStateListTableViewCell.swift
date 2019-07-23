//
//  addrAndStateListTableViewCell.swift
//  Xohri
//
//  Created by Apple on 26/04/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit

class addrAndStateListTableViewCell: UITableViewCell {

    @IBOutlet weak var viewOfList: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
