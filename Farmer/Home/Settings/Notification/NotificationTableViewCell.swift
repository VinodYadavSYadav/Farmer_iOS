//
//  NotificationTableViewCell.swift
//  Farmer
//
//  Created by Apple on 17/06/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var notificationImage: UIImageView!
    @IBOutlet weak var notificationTxtLbl: UILabel!
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    var callback: ((_ switch: UISwitch) -> Void)?
    var value: Bool =  true
    
    
    @IBAction func changedSwitchValue(_ sender: UISwitch) {
        self.value = sender.isOn
        callback?(sender)
        print("Prints when user enables the switch")
            
            if(notificationSwitch.isOn == true) {
                print("Switch is On")
                
            } else {
                print("Switch is Off")
                
            }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print("checking when this function works")
        // Configure the view for the selected state
    }

}
