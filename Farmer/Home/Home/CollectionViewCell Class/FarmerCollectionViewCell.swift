//
//  FarmerCollectionViewCell.swift
//  Farmer
//
//  Created by Apple on 13/06/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit

class FarmerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var completeView: UIView!
    @IBOutlet weak var imageOfItem: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemInformation: UILabel!
    @IBOutlet weak var farmerName: UILabel!
    @IBOutlet weak var location: UIButton!
    @IBOutlet weak var connectBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        connectBtn.layer.cornerRadius = 2
        connectBtn.layer.borderWidth = 1
        connectBtn.layer.borderColor = UIColor.lightGray.cgColor
        
        imageOfItem.layer.cornerRadius = imageOfItem.frame.width / 2
        imageOfItem.clipsToBounds = true
        
    }
}
