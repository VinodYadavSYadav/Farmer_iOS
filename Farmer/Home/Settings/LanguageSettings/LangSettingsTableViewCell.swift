//
//  LangSettingsTableViewCell.swift
//  Xohri
//
//  Created by Apple on 10/04/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit

class LangSettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var completeLangView: UIView!
    @IBOutlet weak var langImage: UIImageView!
    @IBOutlet weak var languageName: UILabel!
    @IBOutlet weak var selectedLangImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        langImage.layer.cornerRadius = langImage.frame.width / 2
        
        completeLangView.layer.cornerRadius = 20
        completeLangView.layer.borderWidth = 2
        completeLangView.layer.borderColor = UIColor.white.cgColor
        completeLangView.backgroundColor = UIColor(red:0.29, green:0.29, blue:0.29, alpha:1.0)
        
        selectedLangImage.layer.cornerRadius = selectedLangImage.frame.width / 2
        selectedLangImage.layer.borderWidth = 2
        selectedLangImage.layer.borderColor = UIColor.white.cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
