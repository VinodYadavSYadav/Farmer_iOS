//
//  FarmTypesVC.swift
//  Farmer
//
//  Created by Apple on 08/07/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit

class FarmTypesVC: UIViewController {

    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var subTiltleLbl: UILabel!
    
    @IBOutlet weak var dairyFarmsBtn: UIButton!
    @IBOutlet weak var goatFarmsBtn: UIButton!
    
    @IBOutlet weak var continueBtn: UIButton!
    
    var typesOfFarms = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueBtn.backgroundColor = UIColor.red
        continueBtn.layer.cornerRadius = 4

    }
    @IBAction func farmTypesBtnAction(_ sender: UIButton) {
        if(sender.tag == 1){
            typesOfFarms = "Dairy Farms"
            dairyFarmsBtn.isSelected = true
            goatFarmsBtn.isSelected = false
            
        }
        else if(sender.tag == 2){
            typesOfFarms = "Goat Farms"
            dairyFarmsBtn.isSelected = false
            goatFarmsBtn.isSelected = true
     
        }

    }
    
    @IBAction func continueBtnAction(_ sender: UIButton) {
        performSegue(withIdentifier: "typeToAddress", sender: self)
    }
    
    @IBAction func closeBtnAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)

//        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
