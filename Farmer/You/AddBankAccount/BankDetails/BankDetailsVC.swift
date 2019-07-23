//
//  BankDetailsVC.swift
//  Xohri
//
//  Created by Apple on 15/05/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import Alamofire

class BankDetailsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
   

    @IBOutlet weak var viewofAllItems: UIView!
    @IBOutlet weak var bankNameView: UIView!
    @IBOutlet weak var bankNameTxtFld: UITextField!
    
    @IBOutlet weak var accountNameView: UIView!
    @IBOutlet weak var accountNumTxtFld: UITextField!
    
    @IBOutlet weak var ifscCodeView: UIView!
    @IBOutlet weak var ifscCodeTxtFld: UITextField!
    
    @IBOutlet weak var holderNameView: UIView!
    @IBOutlet weak var holderNameTxtFld: UITextField!
    
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var popUpListView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var bankListTableView: UITableView!
    
    var dataOfBank = NSArray()
//    var listOfBank = ["Canara","HDFC","SBI","Yes Bank", "BOI"]
    var bankLists = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shadowView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        shadowView.isHidden = true
        
        bankNameTxtFld.delegate = self
        accountNumTxtFld.delegate = self
        ifscCodeTxtFld.delegate = self
        holderNameTxtFld.delegate = self

        popUpListView.layer.cornerRadius = 5
        popUpListView.clipsToBounds = true
        
        viewofAllItems.layer.cornerRadius = 4
        viewofAllItems.layer.borderWidth = 1
        viewofAllItems.layer.borderColor = UIColor(red:0.86, green:0.86, blue:0.86, alpha:1.0).cgColor
        
        bankNameView.layer.cornerRadius = 4
        bankNameView.backgroundColor = UIColor(red:0.86, green:0.86, blue:0.86, alpha:1.0)
        
        accountNameView.layer.cornerRadius = 4
        accountNameView.backgroundColor = UIColor(red:0.86, green:0.86, blue:0.86, alpha:1.0)
        
        ifscCodeView.layer.cornerRadius = 4
        ifscCodeView.backgroundColor = UIColor(red:0.86, green:0.86, blue:0.86, alpha:1.0)
        
        holderNameView.layer.cornerRadius = 4
        holderNameView.backgroundColor = UIColor(red:0.86, green:0.86, blue:0.86, alpha:1.0)
        
        submitBtn.layer.cornerRadius = 3
        submitBtn.tintColor = UIColor.black
        submitBtn.layer.borderColor = UIColor.black.cgColor
        submitBtn.backgroundColor = UIColor(red:0.91, green:0.74, blue:0.10, alpha:1.0)
        submitBtn.layer.borderWidth = 1
        
        if(AddBankAccountVC.addNdEditStatus == "Edit"){
            dataOfBank = AddBankAccountVC.dataOfSelectedBank.value(forKey: "bankDetails") as! NSArray
            print("Printing the data of bank: ",dataOfBank)
            
//            bankNameTxtFld.text = ""
//            accountNumTxtFld.text = ""
//            ifscCodeTxtFld.text = ""
//            holderNameTxtFld.text = ""
        }
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.clearsOnBeginEditing = false
        
        if(textField == bankNameTxtFld){
            shadowView.isHidden = false
            bankListTableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bankLists.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bankNameTxtFld.text = (bankLists[indexPath.row] as AnyObject).value(forKey: "BankName") as? String ?? ""
        shadowView.isHidden = true
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = bankListTableView.dequeueReusableCell(withIdentifier: "listOfBank", for: indexPath)as! ListOfBankVC
        cell.bankNameLbl.text = (bankLists[indexPath.row] as AnyObject).value(forKey: "BankName") as? String ?? ""
        bankNameTxtFld.resignFirstResponder()
        accountNumTxtFld.resignFirstResponder()
        ifscCodeTxtFld.resignFirstResponder()
        holderNameTxtFld.resignFirstResponder()
        
        return cell

    }
    
    func addNewBankDetails() {
        APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: UIActivityIndicatorView.Style.gray)
        self.view.isUserInteractionEnabled = false
        let param: [String: Any]
        
        if(AddBankAccountVC.addNdEditStatus == "AddNewBank") {
            param = ["Id": 0,
                     "CreatedBy" : UserDefaults.standard.integer(forKey: "UserId"),
                     "AccountHolderName": holderNameTxtFld.text!,
                     "BankName": bankNameTxtFld.text!,
                     "AccountNumber": accountNumTxtFld.text!,
                     "IFSCCode": ifscCodeTxtFld.text!
            ]
        } else {
            param = ["Id": AddBankAccountVC.idOfSelectedBank,
                     "CreatedBy" : UserDefaults.standard.integer(forKey: "UserId"),
                     "AccountHolderName": holderNameTxtFld.text!,
                     "BankName": bankNameTxtFld.text!,
                     "AccountNumber": accountNumTxtFld.text!,
                     "IFSCCode": ifscCodeTxtFld.text!
            ]
        }
        
        
        Alamofire.request(APIListForXohri.addNewBankDetails, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [:]).responseJSON {(responds:DataResponse<Any>) in
            switch responds.result {
                
            case .success(_):
                if let data = responds.result.value {
                    let jsonData = data as! NSDictionary
                    
                    let status = jsonData.value(forKey: "Status") as! String
                    let messageStatus = jsonData.value(forKey: "Message") as! String 
                    
                    if(status == "1"){
                        APIListForXohri.showToast(view: self.view, message: messageStatus)
                    }
                    self.navigationController?.popViewController(animated: true)

                }
                
                APIListForXohri.hideActivityIndicator()
                self.view.isUserInteractionEnabled = true
                break
                
            case .failure(_):
                APIListForXohri.hideActivityIndicator()
                self.view.isUserInteractionEnabled = true
                break
            }
        }
        APIListForXohri.hideActivityIndicator()
        self.view.isUserInteractionEnabled = true
    }
    
    func gettingBankList() {
        APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: UIActivityIndicatorView.Style.gray)
        self.view.isUserInteractionEnabled = false
      
        
        Alamofire.request(APIListForXohri.listOfBankInPopUp, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {(responds:DataResponse<Any>) in
            switch responds.result {
                
            case .success(_):
                if let data = responds.result.value {
                    let jsonData = data as! NSDictionary
                    self.bankLists = jsonData.value(forKey: "BankLists") as! NSArray
                    
                }
                
                APIListForXohri.hideActivityIndicator()
                self.view.isUserInteractionEnabled = true
                break
                
            case .failure(_):
                APIListForXohri.hideActivityIndicator()
                self.view.isUserInteractionEnabled = true
                break
            }
        }
        APIListForXohri.hideActivityIndicator()
        self.view.isUserInteractionEnabled = true
    }
    
    
    //RETURNING KEYBOARD.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    @IBAction func submitBtnAction(_ sender: UIButton) {
        if(APIListForXohri.isInternetAvailable() == false) {
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Check Your Internet Connection!!!")
            
        } else {
            addNewBankDetails()
        }
    }
    @IBAction func closeBtnAction(_ sender: UIButton) {
        shadowView.isHidden = true

    }
}
