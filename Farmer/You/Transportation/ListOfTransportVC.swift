//
//  ListOfTransportVC.swift
//  Xohri
//
//  Created by Apple on 28/05/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import Alamofire

class ListOfTransportVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var transportaionListTableView: UITableView!
    @IBOutlet weak var viewOfTransportationBtn: UIView!
    @IBOutlet weak var addNewTransportationBtn: UIButton!
    
    
    var kycDetailsList = NSArray()
    var transportationLists = NSArray()
    static var idOfSelected : Int?
    static var statusOfaddOrEdit : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        viewOfTransportationBtn.layer.cornerRadius = 4
        //        viewOfTransportationBtn.layer.borderColor = UIColor.black.cgColor
        //        viewOfTransportationBtn.layer.borderWidth = 1.5
        //        viewOfTransportationBtn.backgroundColor = UIColor(red:0.86, green:0.86, blue:0.86, alpha:1.0)
        
        if(MyAccountVC.transportOrKYC == "Transportation"){
            addNewTransportationBtn.setTitle("Add New Transportation", for: .normal)
        } else if(MyAccountVC.transportOrKYC == "UpdateKYC") {
            addNewTransportationBtn.setTitle("Add KYC Details", for: .normal)
            
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
    
        if(MyAccountVC.transportOrKYC == "Transportation"){
            if(APIListForXohri.isInternetAvailable() == false) {
                APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Check Your Internet Connection!!!")
                
            } else {
                listOfTransportation()
            }
            
        } else if(MyAccountVC.transportOrKYC == "UpdateKYC") {
            
            if(APIListForXohri.isInternetAvailable() == false) {
                APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Check Your Internet Connection!!!")
                
            } else {
                ListOfKYCDetails()
                
            }
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(MyAccountVC.transportOrKYC == "Transportation"){
            return transportationLists.count
            
        } else {
            return kycDetailsList.count

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = transportaionListTableView.dequeueReusableCell(withIdentifier: "transport", for: indexPath) as! TransportListTableViewCell
        if(MyAccountVC.transportOrKYC == "Transportation"){
            
            cell.editBtn.tag = (self.transportationLists[indexPath.row] as AnyObject).value(forKey: "Id") as! Int
            cell.deleteBtn.tag = (self.transportationLists[indexPath.row] as AnyObject).value(forKey: "Id") as! Int
            
            cell.vehicleTypeLbl.text = (self.transportationLists[indexPath.row] as AnyObject).value(forKey: "TransportationType") as? String ?? ""
            cell.vehicleNumberLbl.text = (self.transportationLists[indexPath.row] as AnyObject).value(forKey: "VehicleNumber") as? String ?? ""
            cell.transportationTypeLbl.text = (self.transportationLists[indexPath.row] as AnyObject).value(forKey: "OwnerName") as? String ?? ""
            
        } else if(MyAccountVC.transportOrKYC == "UpdateKYC") {
            cell.editBtn.isHidden = true
            cell.deleteBtn.isHidden = true

            cell.vehicleTypeLbl.text = (self.kycDetailsList[indexPath.row] as AnyObject).value(forKey: "DocumentType") as? String ?? ""
            cell.vehicleNumberLbl.text = (self.kycDetailsList[indexPath.row] as AnyObject).value(forKey: "NameAsPerID") as? String ?? ""
            cell.transportationTypeLbl.text = (self.kycDetailsList[indexPath.row] as AnyObject).value(forKey: "DocumentNumber") as? String ?? ""
            
        }
        return cell
    }
    
    func listOfTransportation() {
        
        let param = ["CreatedBy": UserDefaults.standard.integer(forKey: "UserId")]
        
        Alamofire.request(APIListForXohri.getTransporationlist, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [:]).responseJSON {(response : DataResponse<Any>) in
            switch response.result{
                
            case .success(_):
                
                if let data = response.result.value {
                    let jsonData = data as! NSDictionary
                    
                    self.transportationLists = jsonData.value(forKey: "TransportationLists") as! NSArray
                    print("printing transportationLists: ", self.transportationLists )
                    self.transportaionListTableView.reloadData()
                    
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
    }
    
    
    
    func ListOfKYCDetails() {
        APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: UIActivityIndicatorView.Style.gray)
        self.view.isUserInteractionEnabled = false
        
        let param = ["UserId" : UserDefaults.standard.integer(forKey: "UserId")]
        
        Alamofire.request(APIListForXohri.listOfKycDetails, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [:]).responseJSON {(responds:DataResponse<Any>) in
            switch responds.result {
                
            case .success(_):
                if let data = responds.result.value {
                    let jsonData = data as! NSDictionary
                    
                    self.kycDetailsList = jsonData.value(forKey: "UserKYCDetails") as! NSArray
                    self.transportaionListTableView.reloadData()
                    
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
    
    func deletetranportationList() {
        
        let param = ["CreatedBy": UserDefaults.standard.integer(forKey: "UserId"),
                     "Id": ListOfTransportVC.idOfSelected]
        
        Alamofire.request(APIListForXohri.deleteTranportationList, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [:]).responseJSON {(response : DataResponse<Any>) in
            switch response.result{
                
            case .success(_):
                
                if let data = response.result.value {
                    let jsonData = data as! NSDictionary
                    let status = jsonData.value(forKey: "Status") as? String
                    if(status != "1"){
                        APIListForXohri.showToast(view: self.view, message: (jsonData.value(forKey: "Message") as? String)!)
                    }
                    
                    self.transportaionListTableView.reloadData()
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
    }
    
    @IBAction func newTransportationBtnAction(_ sender: UIButton) {
        ListOfTransportVC.statusOfaddOrEdit = "AddNewVehicalDetails"
        performSegue(withIdentifier: "Transportation", sender: self)
    }
    @IBAction func editBtnAction(_ sender: UIButton) {
        ListOfTransportVC.idOfSelected = sender.tag
        ListOfTransportVC.statusOfaddOrEdit = "EditVehicalDetails"
        performSegue(withIdentifier: "Transportation", sender: self)

    }
    
    @IBAction func deleteBtnAction(_ sender: UIButton) {
        ListOfTransportVC.idOfSelected = sender.tag

        if(APIListForXohri.isInternetAvailable() == false) {
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Check Your Internet Connection!!!")

        } else {
            deletetranportationList()

        }
    }
}
