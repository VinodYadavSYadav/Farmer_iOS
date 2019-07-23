//
//  LanguageTableViewCell.swift
//  Xohri
//
//  Created by Apple on 14/01/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit

class LanguageTableViewCell: UITableViewCell {

    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var imageOfLang: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
