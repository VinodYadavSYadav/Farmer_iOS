//
//  YourRequestCollectionViewCell.swift
//  Farmer
//
//  Created by Apple on 03/07/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit

class YourRequestCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageOfRequest: UIImageView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageOfRequest.layer.borderWidth = 0.5
        imageOfRequest.layer.borderColor = UIColor(red:0.55, green:0.55, blue:0.55, alpha:1.0).cgColor
        
    }
}
