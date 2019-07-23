//
//  AddNewAddressVC.swift
//  Xohri
//
//  Created by Apple on 16/04/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import  Alamofire

class AddNewAddressVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var addressList: UITableView!
    @IBOutlet weak var addNewAddressBtn: UIButton!
    @IBOutlet weak var selectAddressType: UIButton!
    @IBOutlet weak var viewOfSelectAddr: UIView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var popUpListView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    
    
    @IBOutlet weak var addressTypeTableView: UITableView!
    var userAddressDetails = NSArray()
    static var detailsOfCrop = NSDictionary()
    var addressTypeList = ["Home","Barn","WareHouse","Farm","Others"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
         QuotationRequestVC.addressVariable = "AddNewAddressPage"
        
        self.navigationItem.title = "Add New Address"
        
        popUpListView.layer.cornerRadius = 5
        popUpListView.clipsToBounds = true
        
        shadowView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        shadowView.isHidden = true
        
        viewOfSelectAddr.backgroundColor = UIColor.black
        viewOfSelectAddr.layer.cornerRadius = 3
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        if(APIListForXohri.isInternetAvailable() == false) {
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Check Your Internet Connection!!!")
            
        } else {
            
            gettingUserAddress()
            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == addressTypeTableView) {
            return addressTypeList.count
        } else {
            return userAddressDetails.count
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(tableView == addressTypeTableView) {
            selectAddressType.setTitle(addressTypeList[indexPath.row], for: .normal)
            shadowView.isHidden = true
            
        } else {
            
            ComposeVC.completDetailsOfCrop.setValue(((userAddressDetails[indexPath.row] as AnyObject).value(forKey: "Name") as? String ?? ""), forKey: "NameOfFarmer")
            
            ComposeVC.completDetailsOfCrop.setValue(((userAddressDetails[indexPath.row] as AnyObject).value(forKey: "MobileNo") as? String ?? ""), forKey: "MobileNumberOfFarmer")
            
            ComposeVC.completDetailsOfCrop.setValue(("\(String(describing: (userAddressDetails[indexPath.item] as AnyObject).value(forKey: "StreeAddress") as! String))" + " , " + "\(String(describing: (userAddressDetails[indexPath.item] as AnyObject).value(forKey: "LandMark") as! String))" + " " + "\(String(describing: (userAddressDetails[indexPath.item] as AnyObject).value(forKey: "Pincode") as! String))"), forKey: "AddressOfFarmer")
            
            performSegue(withIdentifier: "addDetails", sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(tableView == addressTypeTableView) {
            let cell = addressTypeTableView.dequeueReusableCell(withIdentifier: "AddressType", for: indexPath) as! AddressTypeTableViewCell
            cell.addressTypeLbl.text = addressTypeList[indexPath.row]
            
            return cell
            
        } else {
            
            
            let cell = addressList.dequeueReusableCell(withIdentifier: "address", for: indexPath) as! AddNewAddressTableViewCell
            cell.completeView.layer.borderColor = UIColor(red:0.87, green:0.87, blue:0.87, alpha:1.0).cgColor
            cell.completeView.layer.borderWidth = 2
            cell.completeView.layer.cornerRadius = 3
            
            cell.nameLbl.text = (userAddressDetails[indexPath.row] as AnyObject).value(forKey: "Name") as? String ?? ""
            cell.phNumLbl.text = "Phone Number: " + "\((userAddressDetails[indexPath.row] as AnyObject).value(forKey: "MobileNo") as? String ?? "")"
            
            cell.addressLbl.text = "Address: " + "\(String(describing: (userAddressDetails[indexPath.item] as AnyObject).value(forKey: "StreeAddress") as! String))" + " , " + "\(String(describing: (userAddressDetails[indexPath.item] as AnyObject).value(forKey: "LandMark") as! String))" + " " + "\(String(describing: (userAddressDetails[indexPath.item] as AnyObject).value(forKey: "Pincode") as! String))"
            
            
            return cell
        }
        
    }
    
    func gettingUserAddress() {
        
        APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: UIActivityIndicatorView.Style.gray)
        self.view.isUserInteractionEnabled = false
        
        let param = ["UserId":UserDefaults.standard.integer(forKey: "UserId")]
        
        
        Alamofire.request(APIListForXohri.getUserAddress, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [:]).responseJSON {(response:DataResponse<Any>) in
            
            switch (response.result){
                
            case .success(_):
                if let data = response.result.value {
                    let jsonData = data as! NSDictionary
                    
                    self.userAddressDetails = jsonData.value(forKey: "UserAddressDetails") as! NSArray
                    
                    APIListForXohri.hideActivityIndicator()
                    self.view.isUserInteractionEnabled = true
                    
                    self.addressList.reloadData()
                    
                }
                break
            case .failure(_):
                APIListForXohri.hideActivityIndicator()
                self.view.isUserInteractionEnabled = true
                break
            }
        }
        
    }
    
    @IBAction func addnewAddressBtnAction(_ sender: UIButton) {
        
        performSegue(withIdentifier: "addNewAddressFromListOfAddress", sender: self)
        
    }
    
    @IBAction func addressTypeBtnAction(_ sender: UIButton) {
        shadowView.isHidden = false
        
    }
    @IBAction func closeBtnAction(_ sender: UIButton) {
        shadowView.isHidden = true
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addNewAddressFromListOfAddress" {
            let backItem = UIBarButtonItem()
            backItem.title = "Add New Address"
            navigationItem.backBarButtonItem = backItem
        }
    }
}
