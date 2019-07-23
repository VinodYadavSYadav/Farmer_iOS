//
//  AddBankAccountVC.swift
//  Xohri
//
//  Created by Apple on 15/05/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import Alamofire


class AddBankAccountVC: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var listOfBankAccountTableView: UITableView!
    @IBOutlet weak var viewOfBankAcc: UIView!
    @IBOutlet weak var addBankAccountBtn: UIButton!
    
    var UserBankDetails = NSArray()
    static var dataOfSelectedBank = NSMutableDictionary()
    
    static var addNdEditStatus = String()
    static var idOfSelectedBank = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBankAccountBtn.layer.borderColor = UIColor.lightGray.cgColor
        addBankAccountBtn.layer.borderWidth = 1
        viewOfBankAcc.backgroundColor = UIColor.white
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if(APIListForXohri.isInternetAvailable() == false) {
            
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Check Your Internet Connection!!!")
            
        } else {
            
            addNewBank()
            
        }
    }
    func addNewBank() {
        APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: UIActivityIndicatorView.Style.gray)
        self.view.isUserInteractionEnabled = false
        
        let param = ["UserId" : UserDefaults.standard.integer(forKey: "UserId")]
        
        Alamofire.request(APIListForXohri.getBankList, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [:]).responseJSON {(responds:DataResponse<Any>) in
            switch responds.result {
                
            case .success(_):
                if let data = responds.result.value {
                    let jsonData = data as! NSDictionary
                    self.UserBankDetails = jsonData.value(forKey: "UserBankDetails") as! NSArray
                    self.listOfBankAccountTableView.reloadData()
                    
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
    
    func deletingCode() {
        APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: UIActivityIndicatorView.Style.gray)
        self.view.isUserInteractionEnabled = false
        
        let param = ["UserId" : UserDefaults.standard.integer(forKey: "UserId"),
                     "Id":AddBankAccountVC.idOfSelectedBank
                    ]
        
        Alamofire.request(APIListForXohri.deletebankList, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [:]).responseJSON {(responds:DataResponse<Any>) in
            switch responds.result {
                
            case .success(_):
                if let data = responds.result.value {
                    let jsonData = data as! NSDictionary
                    let status = jsonData.value(forKey: "Status") as! String
                    let messageStatus = jsonData.value(forKey: "Message") as! String
                    
                    if(status == "1") {
                        APIListForXohri.showToast(view: self.view, message: messageStatus)
                    }
                    
                    self.addNewBank()
                    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserBankDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = listOfBankAccountTableView.dequeueReusableCell(withIdentifier: "BankAccount", for: indexPath) as! BankAccTableViewCell
        
        cell.editBtn.tag = (UserBankDetails[indexPath.row] as AnyObject).value(forKey: "Id") as! Int
        cell.deleteBtn.tag = (UserBankDetails[indexPath.row] as AnyObject).value(forKey: "Id") as! Int

        cell.bankNameLbl.text = (UserBankDetails[indexPath.row] as AnyObject).value(forKey: "BankName") as? String ?? ""
        cell.accountHolderName.text = (UserBankDetails[indexPath.row] as AnyObject).value(forKey: "AccountHolderName") as? String ?? ""
        cell.AccountNum.text = (UserBankDetails[indexPath.row] as AnyObject).value(forKey: "AccountNumber") as? String ?? ""
        cell.ifscNumLbl.text = (UserBankDetails[indexPath.row] as AnyObject).value(forKey: "IFSCCode") as? String ?? ""
        
        return cell
        
    }
    
    @IBAction func addBankAccountBtnAction(_ sender: UIButton) {
        AddBankAccountVC.addNdEditStatus = "AddNewBank"
        performSegue(withIdentifier: "addNewBank", sender: self)
        
    }
    
    @IBAction func editBtnAction(_ sender: UIButton) {
        
        AddBankAccountVC.idOfSelectedBank = sender.tag
        AddBankAccountVC.addNdEditStatus = "Edit"
        
        AddBankAccountVC.dataOfSelectedBank.setValue(((UserBankDetails[sender.tag] as AnyObject).value(forKey: "AccountHolderName") as? String ?? ""), forKey: "AccountHolderName")
        print("printign the data: ", AddBankAccountVC.dataOfSelectedBank.value(forKey: "AccountHolderName")!)
        performSegue(withIdentifier: "addNewBank", sender: self)

    }
    
    @IBAction func deleteBtnAction(_ sender: UIButton) {
        
        AddBankAccountVC.idOfSelectedBank = sender.tag

        print("Printng the value of id: ",AddBankAccountVC.idOfSelectedBank)
        
        if(APIListForXohri.isInternetAvailable() == false) {
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Check Your Internet Connection!!!")
            
        } else {
            deletingCode()
            
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addNewBank" {
            if let childViewController = segue.destination as? BankDetailsVC {
                let backItem = UIBarButtonItem()
                backItem.title = "Add Bank Details"
                navigationItem.backBarButtonItem = backItem
            }
        }
    }
}
