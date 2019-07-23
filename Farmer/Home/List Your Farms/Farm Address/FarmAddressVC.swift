//
//  FarmAddressVC.swift
//  Farmer
//
//  Created by Apple on 08/07/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import ACFloatingTextfield

class FarmAddressVC: UIViewController {
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var subTiltleLbl: UILabel!
    
    @IBOutlet weak var currentLocationBtn: UIButton!
    
    @IBOutlet weak var orLbl: UILabel!
    @IBOutlet weak var colonyTxtFld: ACFloatingTextField!
    @IBOutlet weak var stateTxtFld: ACFloatingTextField!
    @IBOutlet weak var districtTxtFld: ACFloatingTextField!
    @IBOutlet weak var blockTxtFld: ACFloatingTextField!
    
    @IBOutlet weak var talukTxtFld: ACFloatingTextField!
    @IBOutlet weak var villageTxtFld: ACFloatingTextField!
    @IBOutlet weak var pincodeTxtFld: ACFloatingTextField!
    @IBOutlet weak var skipBtn: UIButton!
    
    @IBOutlet weak var continueBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentLocationBtn.layer.cornerRadius = 4
        currentLocationBtn.layer.borderWidth = 1
        currentLocationBtn.layer.borderColor = UIColor.lightGray.cgColor
        
        colonyTxtFld.lineColor = UIColor.darkGray
        colonyTxtFld.selectedLineColor = UIColor(red:0.97, green:0.17, blue:0.11, alpha:1.0)
        colonyTxtFld.placeHolderColor = UIColor.lightGray
        colonyTxtFld.selectedPlaceHolderColor = UIColor.white
        
        stateTxtFld.lineColor = UIColor.darkGray
        stateTxtFld.selectedLineColor = UIColor(red:0.97, green:0.17, blue:0.11, alpha:1.0)
        stateTxtFld.placeHolderColor = UIColor.lightGray
        stateTxtFld.selectedPlaceHolderColor = UIColor.white
        
        districtTxtFld.lineColor = UIColor.darkGray
        districtTxtFld.selectedLineColor = UIColor(red:0.97, green:0.17, blue:0.11, alpha:1.0)
        districtTxtFld.placeHolderColor = UIColor.lightGray
        districtTxtFld.selectedPlaceHolderColor = UIColor.white
        
        blockTxtFld.lineColor = UIColor.darkGray
        blockTxtFld.selectedLineColor = UIColor(red:0.97, green:0.17, blue:0.11, alpha:1.0)
        blockTxtFld.placeHolderColor = UIColor.lightGray
        blockTxtFld.selectedPlaceHolderColor = UIColor.white
        
        talukTxtFld.lineColor = UIColor.darkGray
        talukTxtFld.selectedLineColor = UIColor(red:0.97, green:0.17, blue:0.11, alpha:1.0)
        talukTxtFld.placeHolderColor = UIColor.lightGray
        talukTxtFld.selectedPlaceHolderColor = UIColor.white
        
        villageTxtFld.lineColor = UIColor.darkGray
        villageTxtFld.selectedLineColor = UIColor(red:0.97, green:0.17, blue:0.11, alpha:1.0)
        villageTxtFld.placeHolderColor = UIColor.lightGray
        villageTxtFld.selectedPlaceHolderColor = UIColor.white
        
        pincodeTxtFld.lineColor = UIColor.darkGray
        pincodeTxtFld.selectedLineColor = UIColor(red:0.97, green:0.17, blue:0.11, alpha:1.0)
        pincodeTxtFld.placeHolderColor = UIColor.lightGray
        pincodeTxtFld.selectedPlaceHolderColor = UIColor.white
        
        continueBtn.backgroundColor = UIColor(red:0.97, green:0.17, blue:0.11, alpha:1.0)
        continueBtn.layer.cornerRadius = 4
        
    
    }
    
    @IBAction func continueBtnAction(_ sender: UIButton) {
        performSegue(withIdentifier: "locationToDetailsPage", sender: self)
    }
    
    @IBAction func currentLocationBtnAction(_ sender: UIButton) {
        performSegue(withIdentifier: "currentlocationBtnNavigation", sender: self)

    }
    @IBAction func closeBtnAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
//        self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func skipBtnAction(_ sender: UIButton) {
        performSegue(withIdentifier: "locationToDetailsPage", sender: self)
    }
    
}
