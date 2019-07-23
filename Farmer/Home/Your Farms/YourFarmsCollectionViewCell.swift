//
//  YourFarmsCollectionViewCell.swift
//  Farmer
//
//  Created by Apple on 03/07/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit

class YourFarmsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var farmimage: UIImageView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var nameOfFarm: UILabel!
    @IBOutlet weak var locationOfFarm: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        editButton.layer.cornerRadius = editButton.frame.width / 2
        editButton.backgroundColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
        
    }
    
    
}
