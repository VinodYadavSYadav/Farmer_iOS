//
//  MyAccountVC.swift
//  Xohri
//
//  Created by Apple on 19/02/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit

class MyAccountVC: UIViewController {

    @IBOutlet weak var scrollViewOfAccount: UIScrollView!
    @IBOutlet weak var imageNameView: UIView!
    @IBOutlet weak var imageOfFarmer: UIImageView!
    @IBOutlet weak var nameOfFarmer: UILabel!
    @IBOutlet weak var phNumOfFarmer: UILabel!
    @IBOutlet weak var editDetailsBtn: UIButton!
    @IBOutlet weak var accountView: UIView!
    
    @IBOutlet weak var transportationLbl: UILabel!
    @IBOutlet weak var transportationBtn: UIButton!
    
    @IBOutlet weak var yourAddressLbl:UILabel!
    @IBOutlet weak var yourAddressBtn: UIButton!
    
    @IBOutlet weak var referEarnLbl: UILabel!
    @IBOutlet weak var referEarnBtn: UIButton!
    
    @IBOutlet weak var bankAccountLbl: UILabel!
    @IBOutlet weak var bankAccountBtn: UIButton!
    
    @IBOutlet weak var addMoneyLbl: UILabel!
    @IBOutlet weak var addMoneyBtn: UIButton!
    
    @IBOutlet weak var transactionLbl: UILabel!
    @IBOutlet weak var transactionBtn: UIButton!
    
    @IBOutlet weak var walletLbl: UILabel!
    @IBOutlet weak var walletBtn: UIButton!
    
    @IBOutlet weak var updateKycLbl: UILabel!
    @IBOutlet weak var updateKycBtn: UIButton!
    
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var changelanguageLbl:UILabel!
    @IBOutlet weak var changeLanguageBtn: UIButton!
    
    @IBOutlet weak var notificationbLbl: UILabel!
    @IBOutlet weak var notificationBtn: UIButton!
    
    @IBOutlet weak var changePassLbl: UILabel!
    @IBOutlet weak var changePassBtn: UIButton!
    
    @IBOutlet weak var helpSupportLbl: UILabel!
    @IBOutlet weak var helpSupportBtn: UIButton!
    
    @IBOutlet weak var aboutUsLbl: UILabel!
    @IBOutlet weak var aboutUsBtn: UIButton!
    
    @IBOutlet weak var logOutLbl: UILabel!
    @IBOutlet weak var logOutBtn: UIButton!
  
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var thirdView: UIView!
    
    static var btnStatus = String()
    
    static var transportOrKYC = String()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.isNavigationBarHidden = true
        scrollViewOfAccount.showsVerticalScrollIndicator = false
        
        let XScale = UIScreen.main.bounds.size.width / 320.0
        let YScale = UIScreen.main.bounds.size.height / 568.0

            
        nameOfFarmer.textColor = UIColor(red:0.54, green:0.55, blue:0.57, alpha:1.0)
        phNumOfFarmer.textColor = UIColor(red:0.54, green:0.55, blue:0.57, alpha:1.0)
        
        transportationLbl.textColor = UIColor(red:0.54, green:0.55, blue:0.57, alpha:1.0)
        yourAddressLbl.textColor = UIColor(red:0.54, green:0.55, blue:0.57, alpha:1.0)
        referEarnLbl.textColor = UIColor(red:0.54, green:0.55, blue:0.57, alpha:1.0)
        
        bankAccountLbl.textColor = UIColor(red:0.54, green:0.55, blue:0.57, alpha:1.0)
        addMoneyLbl.textColor = UIColor(red:0.54, green:0.55, blue:0.57, alpha:1.0)
        transactionLbl.textColor = UIColor(red:0.54, green:0.55, blue:0.57, alpha:1.0)
        walletLbl.textColor = UIColor(red:0.54, green:0.55, blue:0.57, alpha:1.0)
        updateKycLbl.textColor = UIColor(red:0.54, green:0.55, blue:0.57, alpha:1.0)
        
        changelanguageLbl.textColor = UIColor(red:0.54, green:0.55, blue:0.57, alpha:1.0)
        notificationbLbl.textColor = UIColor(red:0.54, green:0.55, blue:0.57, alpha:1.0)
        changePassLbl.textColor = UIColor(red:0.54, green:0.55, blue:0.57, alpha:1.0)
        helpSupportLbl.textColor = UIColor(red:0.54, green:0.55, blue:0.57, alpha:1.0)
        aboutUsLbl.textColor = UIColor(red:0.54, green:0.55, blue:0.57, alpha:1.0)
        logOutLbl.textColor = UIColor(red:0.54, green:0.55, blue:0.57, alpha:1.0)
        
        imageOfFarmer.layer.borderWidth = 1
        imageOfFarmer.layer.borderColor = UIColor(red:0.54, green:0.55, blue:0.57, alpha:1.0).cgColor
        imageOfFarmer.layer.cornerRadius = imageOfFarmer.frame.size.width / 2
    }
    
    @IBAction func transportationBtnAction(_ sender: UIButton) {
        MyAccountVC.transportOrKYC = "Transportation"

        MyAccountVC.btnStatus = "Storage_And_Transportation"
        performSegue(withIdentifier: "Transportation", sender: self)

    }
    
    @IBAction func walletBtnAction(_ sender: UIButton) {
        performSegue(withIdentifier: "walletPage", sender: self)
    }
    
    @IBAction func addBankBtnAction(_ sender: UIButton) {
        MyAccountVC.btnStatus = "Add_Bank_Acconuts"
        performSegue(withIdentifier: "savedBanks", sender: self)

    }
    
    @IBAction func addMoneyBtnAction(_ sender: UIButton) {
    }
    
    @IBAction func transactionBtnAction(_ sender: UIButton) {
    }
    
    @IBAction func addressBtnAction(_sender: UIButton) {
        performSegue(withIdentifier: "addAddress", sender: self)
    }
    
    @IBAction func referEarnBtnAction(_ sender: UIButton) {
        
    }
    
    @IBAction func updateKycBtnAction(_ sender: UIButton) {
       MyAccountVC.transportOrKYC = "UpdateKYC"
        
        performSegue(withIdentifier: "Transportation", sender: self)
    }
    
    @IBAction func changeLangBtnAction(_ sender: UIButton) {
        
        performSegue(withIdentifier: "languageSettings", sender: self)
    }
    
    @IBAction func notificationBtnAction(_ sender: UIButton) {
        
        
    }
    
    @IBAction func changePassBtnAction(_ sender: UIButton) {
        performSegue(withIdentifier: "changePassword", sender: nil)
    }
    
    @IBAction func helpSupportBtnAction(_ sender: UIButton) {
        if let url = URL(string: "http://renewin.com/"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @IBAction func aboutUsBtnAction(_ sender: UIButton) {
        if let url = URL(string: "http://renewin.com/"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
  
    @IBAction func logOutBtnAction(_ sender: UIButton) {
        performSegue(withIdentifier: "YouToAccount", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Transportation" {
            let backItem = UIBarButtonItem()
            backItem.title = "Enter Transportation Details"
            navigationItem.backBarButtonItem = backItem
        }
        
        if segue.identifier == "addAddress" {
            let backItem = UIBarButtonItem()
            backItem.title = "Select Your Address"
            navigationItem.backBarButtonItem = backItem
        }
        
        if segue.identifier == "savedBanks" {
            let backItem = UIBarButtonItem()
            backItem.title = "Your Saved Bank Accounts"
            navigationItem.backBarButtonItem = backItem
        }
        
        if segue.identifier == "walletPage"{
            let backItem = UIBarButtonItem()
            backItem.title = "Wallet"
            navigationItem.backBarButtonItem = backItem
        }
        
        if segue.identifier == "languageSettings" {
            let backItem = UIBarButtonItem()
            backItem.title = "Language Setting"
            navigationItem.backBarButtonItem = backItem
        }
        
        if segue.identifier == "changePassword" {
            let backItem = UIBarButtonItem()
            backItem.title = "Add New Address"
            navigationItem.backBarButtonItem = backItem
        }
    }
}
