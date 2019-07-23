//
//  WalletTableViewCell.swift
//  Xohri
//
//  Created by Apple on 29/03/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit

class WalletTableViewCell: UITableViewCell {

    @IBOutlet weak var imageOfCoins: UIImageView!
    @IBOutlet weak var rupeesLbl: UILabel!
    @IBOutlet weak var moneyBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
