//
//  BankAccTableViewCell.swift
//  Xohri
//
//  Created by Apple on 15/05/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit

class BankAccTableViewCell: UITableViewCell {

    @IBOutlet weak var completeView: UIView!
    @IBOutlet weak var bankNameLbl: UILabel!
    @IBOutlet weak var accountHolderName: UILabel!
    @IBOutlet weak var AccountNum: UILabel!
    @IBOutlet weak var ifscNumLbl: UILabel!
    
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        completeView.layer.cornerRadius = 4
        completeView.layer.borderColor = UIColor(red:0.86, green:0.86, blue:0.86, alpha:1.0).cgColor
        completeView.layer.borderWidth = 1.5

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
