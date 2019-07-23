//
//  FarmCategoriesVC.swift
//  Farmer
//
//  Created by Apple on 08/07/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit

class FarmCategoriesVC: UIViewController {

    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var subTiltleLbl: UILabel!
    @IBOutlet weak var irrigatedBtn: UIButton!
    @IBOutlet weak var liveStockBtn: UIButton!
    @IBOutlet weak var nonIrrigatedBtn: UIButton!
    @IBOutlet weak var organicBtn: UIButton!
    @IBOutlet weak var plantationBtn: UIButton!
    @IBOutlet weak var continueBtn: UIButton!
    
    var categories = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueBtn.backgroundColor = UIColor.red
        continueBtn.layer.cornerRadius = 4
    }
    
    @IBAction func farmCategoriesBtnAction(_ sender: UIButton) {
        if(sender.tag == 1){
            categories = "Irrigation"
            irrigatedBtn.isSelected = true
            liveStockBtn.isSelected = false
            nonIrrigatedBtn.isSelected = false
            organicBtn.isSelected = false
            plantationBtn.isSelected = false
        }
        else if(sender.tag == 2){
            categories = "LiveStock"
            irrigatedBtn.isSelected = false
            liveStockBtn.isSelected = true
            nonIrrigatedBtn.isSelected = false
            organicBtn.isSelected = false
            plantationBtn.isSelected = false
        }
        else if(sender.tag == 3){
            categories = "NonIrrigation"
            irrigatedBtn.isSelected = false
            liveStockBtn.isSelected = false
            nonIrrigatedBtn.isSelected = true
            organicBtn.isSelected = false
            plantationBtn.isSelected = false
        }
        else if(sender.tag == 4){
            categories = "Organic"
            irrigatedBtn.isSelected = false
            liveStockBtn.isSelected = false
            nonIrrigatedBtn.isSelected = false
            organicBtn.isSelected = true
            plantationBtn.isSelected = false
            
        } else if(sender.tag == 5){
            categories = "Planantion"
            irrigatedBtn.isSelected = false
            liveStockBtn.isSelected = false
            nonIrrigatedBtn.isSelected = false
            organicBtn.isSelected = false
            plantationBtn.isSelected = true

        }
        
    }
    
    @IBAction func continueBtnAction(_ sender: UIButton) {
        performSegue(withIdentifier: "categoryToType", sender: self)
    }
    
    @IBAction func closeBtnAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
