//
//  TransportListTableViewCell.swift
//  Xohri
//
//  Created by Apple on 28/05/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit

class TransportListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var completeView: UIView!
    @IBOutlet weak var vehicleTypeLbl: UILabel!
    @IBOutlet weak var vehicleNumberLbl: UILabel!
    @IBOutlet weak var transportationTypeLbl: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        completeView.layer.cornerRadius = 4
        completeView.layer.borderColor = UIColor(red:0.86, green:0.86, blue:0.86, alpha:1.0).cgColor
        completeView.layer.borderWidth = 1.5
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
