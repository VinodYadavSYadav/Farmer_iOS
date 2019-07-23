//
//  TransportationDetailsVC.swift
//  Xohri
//
//  Created by Apple on 28/05/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import  Alamofire

class TransportationDetailsVC: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var transportLbl: UILabel!
    @IBOutlet weak var transportationMethodView: UIView!
    @IBOutlet weak var transportationMethodTxtFld: UITextField!
    
    @IBOutlet weak var vehicleNumLbl: UILabel!
    @IBOutlet weak var vehicleNumView: UIView!
    @IBOutlet weak var vehicleNumTxtFld: UITextField!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameTxtFld: UITextField!
    
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var popUpListView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var documentTypeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transportationMethodTxtFld.delegate = self
        vehicleNumTxtFld.delegate = self
        nameTxtFld.delegate = self
        
        shadowView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        shadowView.isHidden = true
        
        popUpListView.layer.cornerRadius = 5
        popUpListView.clipsToBounds = true
        
        transportationMethodView.layer.cornerRadius = 4
        transportationMethodView.backgroundColor = UIColor(red:0.86, green:0.86, blue:0.86, alpha:1.0)
        
        vehicleNumView.layer.cornerRadius = 4
        vehicleNumView.backgroundColor = UIColor(red:0.86, green:0.86, blue:0.86, alpha:1.0)
        
        nameView.layer.cornerRadius = 4
        nameView.backgroundColor = UIColor(red:0.86, green:0.86, blue:0.86, alpha:1.0)
        
        submitBtn.layer.cornerRadius = 3
        submitBtn.tintColor = UIColor.black
        submitBtn.layer.borderColor = UIColor.black.cgColor
        submitBtn.backgroundColor = UIColor(red:0.91, green:0.74, blue:0.10, alpha:1.0)
        
        if(MyAccountVC.transportOrKYC == "Transportation"){
            transportLbl.text = "Select Your Transportation"
            vehicleNumLbl.text = "Vehicle Number"
            nameLbl.text = "Name"
            submitBtn.setTitle("Submit", for: .normal)
            
        } else if(MyAccountVC.transportOrKYC == "UpdateKYC") {
            transportLbl.text = "Document Type"
            vehicleNumLbl.text = "License Number"
            nameLbl.text = "Name as per ID"
            submitBtn.setTitle("Verify", for: .normal)
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = documentTypeTableView.dequeueReusableCell(withIdentifier: "DocType", for: indexPath)as! DocTypeTableViewCell
        return cell
        
    }
    func editAddTransportationList() {
        
        let param: [String: Any]
        
        if(ListOfTransportVC.statusOfaddOrEdit == "AddNewVehicalDetails") {
            param = ["Id": "",
                     "CreatedBy" : UserDefaults.standard.integer(forKey: "UserId"),
                     "VehicleNumber":"KA27EC3093",
                     "OwnerName":"Manoj",
                     "TransportationType":"AAA"
            ]
        } else {
            param = ["Id": ListOfTransportVC.idOfSelected,
                     "CreatedBy" : UserDefaults.standard.integer(forKey: "UserId"),
                     "VehicleNumber":"KA27EC3093",
                     "OwnerName":"Manoj",
                     "TransportationType":"AAA"
            ]
        }
        Alamofire.request(APIListForXohri.addEditTransportation, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [:]).responseJSON {(response : DataResponse<Any>) in
            switch response.result{
                
            case .success(_):
                
                if let data = response.result.value {
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
    }
    
    func updateKYCDetails() {
        APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: UIActivityIndicatorView.Style.gray)
        self.view.isUserInteractionEnabled = false
        let param: [String: Any] = [
            "DocumentType": transportationMethodTxtFld.text!,
            "DocumentNumber": vehicleNumTxtFld.text!,
            "NameAsPerID": nameTxtFld.text!,
            "CreatedBy" : UserDefaults.standard.integer(forKey: "UserId"),
            
            ]
        
        Alamofire.request(APIListForXohri.updateKYCDetails, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [:]).responseJSON {(responds:DataResponse<Any>) in
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
    @IBAction func submitBtnAction(_ sender: UIButton) {
        
        if(MyAccountVC.transportOrKYC == "Transportation"){
            
            
        } else if(MyAccountVC.transportOrKYC == "UpdateKYC"){
            
            if(APIListForXohri.isInternetAvailable() == false) {
                APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Check Your Internet Connection!!!")
                
            } else {
                updateKYCDetails()
            }
        }
    }
    
}
