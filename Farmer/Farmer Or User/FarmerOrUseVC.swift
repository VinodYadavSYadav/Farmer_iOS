//
//  FarmerOrUseVC.swift
//  Farmer
//
//  Created by Apple on 18/06/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit

class FarmerOrUseVC: UIViewController {

    @IBOutlet weak var farmerLbl: UILabel!
    
    @IBOutlet weak var farmerView: UIView!
    @IBOutlet weak var userView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        farmerView.backgroundColor = UIColor(red:0.29, green:0.29, blue:0.29, alpha:1.0)
        userView.backgroundColor = UIColor(red:0.29, green:0.29, blue:0.29, alpha:1.0)
        
    }
    
    @IBAction func farmerOrUserBtn(_ sender: UIButton) {
        if(sender.tag == 1){
            userView.layer.borderColor = UIColor(red:0.29, green:0.29, blue:0.29, alpha:1.0).cgColor
            farmerView.layer.borderWidth = 2
            farmerView.layer.borderColor = UIColor.white.cgColor
        } else {
            farmerView.layer.borderColor = UIColor(red:0.29, green:0.29, blue:0.29, alpha:1.0).cgColor
            userView.layer.borderWidth = 2
            userView.layer.borderColor = UIColor.white.cgColor
        }
    }
    
}
