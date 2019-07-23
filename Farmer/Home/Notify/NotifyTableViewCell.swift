//
//  NotifyTableViewCell.swift
//  Farmer
//
//  Created by Apple on 04/07/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit

class NotifyTableViewCell: UITableViewCell {

    @IBOutlet weak var completeView: UIView!
    @IBOutlet weak var imageOfUser: UIImageView!
    @IBOutlet weak var notificationMsgLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        completeView.backgroundColor = UIColor(red:0.29, green:0.29, blue:0.29, alpha:1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
