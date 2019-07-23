//
//  AddNewAddressTableViewCell.swift
//  Xohri
//
//  Created by Apple on 16/04/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit

class AddNewAddressTableViewCell: UITableViewCell {

    @IBOutlet weak var completeView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var phNumLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
