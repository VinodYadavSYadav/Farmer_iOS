//
//  AddingAddressVC.swift
//  Xohri
//
//  Created by Apple on 16/04/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import Alamofire

class AddingAddressVC: UIViewController, UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var addressType: UIButton!
    @IBOutlet weak var fullNameTxtFld: UITextField!
    @IBOutlet weak var PhnumTxtFld: UITextField!
    @IBOutlet weak var pincodeTxtFld: UITextField!
    @IBOutlet weak var colonytxtFld: UITextField!
    
    @IBOutlet weak var selectState: UIButton!
    @IBOutlet weak var distBtn: UIButton!
    @IBOutlet weak var talukBtn: UIButton!
    @IBOutlet weak var hobliBtn: UIButton!
    @IBOutlet weak var villageBtn: UIButton!
    @IBOutlet weak var viewOfAddrType: UIView!
    
    @IBOutlet weak var selectStateview:UIView!
    @IBOutlet weak var selectDistView: UIView!
    @IBOutlet weak var selectTalukView: UIView!
    @IBOutlet weak var selectHobliView: UIView!
    @IBOutlet weak var selectVillageView: UIView!
    @IBOutlet weak var viewOfStack: UIView!
    
    @IBOutlet weak var addAddressBtn: UIButton!
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var listsPopUpView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    
    @IBOutlet weak var listTableView: UITableView!
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var phNumView: UIView!
    @IBOutlet weak var pincodeView: UIView!
    @IBOutlet weak var colonyView: UIView!
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var sideMenuConstraints: NSLayoutConstraint!
    @IBOutlet weak var dropDownView: UIView!
    @IBOutlet weak var dropDownLocationTableView: UITableView!
    @IBOutlet weak var submitBtn: UIButton!
    
    var statusOfAddress = String()
    var addrandState = String()
    var addressTypeList = ["Home","Barn","WareHouse","Farm","Others"]
    //    var stateList = ["Karnataka"]
    var tableData = NSArray()
    
    var isData = String()
    
    var stateId = Int()
    var districtId = Int()
    var talkuId = Int()
    var hobliId = Int()
    var villageId = Int()
    var pickUpfrom = String()
    static var addressId = Int()
    
    var slideMenuStatus = Bool()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewOfAddrType.backgroundColor = UIColor.black
        viewOfAddrType.layer.cornerRadius = 3
        
        selectStateview.backgroundColor = UIColor.black
        selectStateview.layer.cornerRadius = 3
        
        listsPopUpView.layer.cornerRadius = 5
        listsPopUpView.clipsToBounds = true
        
        shadowView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        shadowView.isHidden = true
        
        viewOfStack.backgroundColor = UIColor.groupTableViewBackground
        viewOfStack.layer.cornerRadius = 4
        
        viewOfAddrType.backgroundColor = UIColor.black
        viewOfAddrType.layer.cornerRadius = 2
        
        selectStateview.backgroundColor = UIColor.black
        selectStateview.layer.cornerRadius = 2
        
        addAddressBtn.backgroundColor = UIColor(red:0.97, green:0.17, blue:0.11, alpha:1.0)
        addAddressBtn.layer.cornerRadius = 4
        
        fullNameTxtFld.delegate = self
        PhnumTxtFld.delegate = self
        pincodeTxtFld.delegate = self
        colonytxtFld.delegate = self
        
        nameView.backgroundColor = UIColor.groupTableViewBackground
        nameView.layer.cornerRadius = 4
        
        phNumView.backgroundColor = UIColor.groupTableViewBackground
        phNumView.layer.cornerRadius = 4
        
        pincodeView.backgroundColor = UIColor.groupTableViewBackground
        pincodeView.layer.cornerRadius = 4
        
        colonyView.backgroundColor = UIColor.groupTableViewBackground
        colonyView.layer.cornerRadius = 4
        
        doneButtonAction()
        
        
        dropDownLocationTableView.delegate = self
        dropDownLocationTableView.dataSource =  self
        
        dropDownLocationTableView.allowsSelection = true
        
        slideMenuStatus = false
        sideMenuConstraints.constant = 240
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                sideMenuConstraints.constant = 240
                shadowView.isHidden = true
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()
                })
                slideMenuStatus = !slideMenuStatus
                break
            default:
                break
            }
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == fullNameTxtFld){
            if(string.isInt){
                return false
            }
        }
        if(textField == PhnumTxtFld){
            
            let currentStr = textField.text! as NSString
            let newStr : NSString =  currentStr.replacingCharacters(in: range, with: string) as NSString
            if !(string.isInt){
                if(string != ""){
                    return false
                }
            }
            else{
                return newStr.length <= 10
            }
        }
        if(textField == pincodeTxtFld){
            let currentStr : NSString = textField.text! as NSString
            let newStr : NSString = currentStr.replacingCharacters(in: range, with: string) as NSString
            if !(string.isInt){
                if(string != ""){
                    return false
                }
            }
            else{
                return newStr.length <= 6
            }
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if(addrandState == "Address"){
//            return addressTypeList.count
//        }
//        else {
            if(isData == "StateList"){
                return tableData.count
            }
            else if(isData == "DistrictList"){
                return tableData.count
            }
            else if(isData == "TalukList"){
                return tableData.count
            }
            else if(isData == "HobliList"){
                return tableData.count
            }
            else {
                return tableData.count
            }
        //}
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if(addrandState == "Address"){
//            return 50
//        } else {
            return 50
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dropDownLocationTableView.dequeueReusableCell(withIdentifier: "location", for: indexPath)as! LocationDDTableViewCell
//        let cell = listTableView.dequeueReusableCell(withIdentifier: "addressAndStateList", for: indexPath)as! addrAndStateListTableViewCell

//        if(addrandState == "Address"){
//            cell.nameLbl.text = addressTypeList[indexPath.row]
//        }
//        else {
            if(isData == "StateList"){
                cell.locationNameLbl.text = (tableData[indexPath.row] as AnyObject).value(forKey: "State") as? String
            }
            else if(isData == "DistrictList"){
                cell.locationNameLbl.text = (tableData[indexPath.row] as AnyObject).value(forKey: "District") as? String
            }
            else if(isData == "TalukList"){
                cell.locationNameLbl.text = (tableData[indexPath.row] as AnyObject).value(forKey: "Taluk") as? String
            }
            else if(isData == "HobliList"){
                cell.locationNameLbl.text = (tableData[indexPath.row] as AnyObject).value(forKey: "Hobli") as? String
            }
            else if(isData == "VillageList"){
                cell.locationNameLbl.text = (tableData[indexPath.row] as AnyObject).value(forKey: "Village") as? String
            }
            else{
                print("Something wrong")
            }
        //}
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if(addrandState == "Address") {
//            pickUpfrom = addressTypeList[indexPath.row]
//            addressType.setTitle(addressTypeList[indexPath.row], for: .normal)
//            shadowView.isHidden = true
//        }
//        else {
        
        
        if(isData == "StateList"){
                if(stateId != (self.tableData[indexPath.row] as AnyObject).value(forKey: "StateId") as? Int){
                    distBtn.setTitle("District", for: .normal)
                    talukBtn.setTitle("Taluk", for: .normal)
                    hobliBtn.setTitle("Hobli", for: .normal)
                    villageBtn.setTitle("Village", for: .normal)
                    districtId = 0
                    talkuId = 0
                    hobliId = 0
                    villageId = 0
                }
                stateId = (self.tableData[indexPath.row] as AnyObject).value(forKey: "StateId") as? Int ?? 0
                selectState.setTitle((tableData[indexPath.row] as? AnyObject)?.value(forKey: "State") as? String, for: .normal)
                
                tableData = []
                dropDownLocationTableView.reloadData()
//                listTableView.reloadData()
                print("State id selected is different from previous one",self.stateId," districtId:",districtId," talkuId:",talkuId," villageId:",villageId," hobliId:",hobliId)
            }
            else if(isData == "DistrictList"){
                if(districtId != (self.tableData[indexPath.row] as AnyObject).value(forKey: "DistrictId") as? Int){
                    talukBtn.setTitle("Taluk", for: .normal)
                    hobliBtn.setTitle("Hobli", for: .normal)
                    villageBtn.setTitle("Village", for: .normal)
                    talkuId = 0
                    hobliId = 0
                    villageId = 0
                }
                districtId = (self.tableData[indexPath.row] as AnyObject).value(forKey: "DistrictId") as? Int ?? 0
                distBtn.setTitle((tableData[indexPath.row] as AnyObject).value(forKey: "District") as? String, for: .normal)
                tableData = []
                dropDownLocationTableView.reloadData()
//                listTableView.reloadData()
            }
            else if(isData == "TalukList"){
                if(talkuId != (self.tableData[indexPath.row] as AnyObject).value(forKey: "TalukId") as? Int){
                    hobliBtn.setTitle("Hobli", for: .normal)
                    villageBtn.setTitle("Village", for: .normal)
                    hobliId = 0
                    villageId = 0
                }
                talukBtn.setTitle((tableData[indexPath.row] as AnyObject).value(forKey: "Taluk") as? String, for: .normal)
                talkuId = (self.tableData[indexPath.row] as AnyObject).value(forKey: "TalukId") as? Int ?? 0
                tableData = []
                dropDownLocationTableView.reloadData()
//                listTableView.reloadData()
            }
            else if(isData == "HobliList"){
                if(talkuId != (self.tableData[indexPath.row] as AnyObject).value(forKey: "HobliId") as? Int){
                    villageBtn.setTitle("Village", for: .normal)
                    villageId = 0
                }
                hobliBtn.setTitle((tableData[indexPath.row] as AnyObject).value(forKey: "Hobli") as? String, for: .normal)
                hobliId = (tableData[indexPath.row] as AnyObject).value(forKey: "HobliId") as? Int ?? 0
                tableData = []
                dropDownLocationTableView.reloadData()
//                listTableView.reloadData()
            }
            shadowView.isHidden = true
        //}
    }
    
    func getStates(){
        Alamofire.request(APIListForXohri.getStates, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {(response : DataResponse<Any>) in
            switch response.result{
            case .success(_):
              //let responseData = response.result.value as? NSDictionary
                self.tableData = []
                self.isData = ""
                self.isData = "StateList"
                self.tableData = (response.result.value as? NSArray)!
                self.dropDownLocationTableView.reloadData()
//                listTableView.reloadData()
                break
                
            case .failure(_):
                break
            }
        }
    }
    
    func getDistricts(){
        let data = ["StateId":stateId]//29]
        let param = ["Districtobj":data]
        Alamofire.request(APIListForXohri.getDistricts, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [:]).responseJSON {(response : DataResponse<Any>) in
            switch response.result{
                
            case .success(_):
                let res = response.result.value as? NSDictionary
                self.tableData = []
                self.isData = ""
                self.isData = "DistrictList"
                self.tableData = (res?.value(forKey: "DistrictList") as? NSArray)!
                self.dropDownLocationTableView.reloadData()
//                listTableView.reloadData()
                break
                
            case .failure(_):
                break
            }
        }
    }
    
    func getTaluks(){
        let data = ["DistrictId": districtId]//564]
        let param = ["Talukobj":data]
        Alamofire.request(APIListForXohri.getTaluks, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [:]).responseJSON {(response : DataResponse<Any>) in
            switch response.result{
                
            case .success(_):
                let res = response.result.value as? NSDictionary
                self.tableData = []
                self.isData = ""
                self.isData = "TalukList"
                self.tableData = (res?.value(forKey: "TalukList") as? NSArray)!
                self.dropDownLocationTableView.reloadData()
//                listTableView.reloadData()
                break
                
            case .failure(_):
                break
            }
        }
    }
    
    func getHoblies(){
        let data = ["TalukId":talkuId]
        let param = ["Hobliobj":data]
        Alamofire.request(APIListForXohri.getHoblies, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [:]).responseJSON {(response : DataResponse<Any>) in
            switch response.result{
                
            case .success(_):
                let res = response.result.value as? NSDictionary
                self.tableData = []
                self.isData = ""
                self.isData = "HobliList"
                self.tableData = (res?.value(forKey: "HobliList") as? NSArray)!
               // self.hobliId = self.tableData.value(forKey: "HobliId") as? Int ?? 0
                self.dropDownLocationTableView.reloadData()
//                listTableView.reloadData()
                break
                
            case .failure(_):
                break
            }
        }
    }
    
    func getVillages(){
        let data = ["HobliId":hobliId]
        let param = ["Villageobj":data]
        Alamofire.request(APIListForXohri.getVillages, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [:]).responseJSON {(response:DataResponse<Any>) in
            switch response.result{
                
            case .success(_):
                print("Printing getVillages service call response from AddingAddressVC:",response.result.value)
                let res = response.result.value as? NSDictionary
                self.tableData = []
                self.isData = ""
                self.isData = "HobliList"
                self.tableData = (res?.value(forKey: "VillageList") as? NSArray)!
                self.listTableView.reloadData()
                
            case .failure(_):
                print("getVillages service call failed in AddingAddressVC:",response.result.value)
            }
        }
    }
    
    func addNewAddress() {
        APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: UIActivityIndicatorView.Style.gray)
        self.view.isUserInteractionEnabled = false
        let param = ["Name": fullNameTxtFld.text!,
            "MobileNo": PhnumTxtFld.text!,
            "StreeAddress": "",//,flatNumTxtFld.text!,
            "StreeAddress1": colonytxtFld.text!,
            "LandMark": "", // landmarkTxtFld.text!,
            "StateId": stateId,//"29",
            "DistrictId": districtId,//"561",
            "TalukId": talkuId,//"5470",
            "HobliId": hobliId,//"601990",
            "VillageId": "2",
            "City":"", //cityTxtFld.text!,
            "PickUpFrom":pickUpfrom,
            "Pincode": pincodeTxtFld.text!,
            "UserId":UserDefaults.standard.integer(forKey: "UserId")] as [String : Any]
        print("Printing parameters of addNewAddress service call:",param)
        Alamofire.request(APIListForXohri.addNewAddress, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [:]).responseJSON {(response:DataResponse<Any>) in
            switch (response.result){
                
            case .success(_):
                if let data = response.result.value {
                    let jsonData = data as! NSDictionary
                    let status = jsonData.value(forKey: "Status") as? String
                    let messageStatus = jsonData.value(forKey: "Message")  as? String ?? ""
                    print("Printing addNewAddress service call response in AddingAddressVC:",jsonData)
                    AddingAddressVC.addressId = Int(status!)!
                 //   APIListForXohri.showAlertMessage(vc: self, messageStr: messageStatus)
                        let alert = UIAlertController(title: "Message", message: messageStatus, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action:UIAlertAction!) in
                            self.navigationController?.popViewController(animated: true)
                        }))
                        self.present(alert, animated: true, completion: nil)
                    APIListForXohri.hideActivityIndicator()
                    self.view.isUserInteractionEnabled = true
                }
                break
            case .failure(_):
                APIListForXohri.hideActivityIndicator()
                self.view.isUserInteractionEnabled = true
                break
            }
        }
    }
    
    
    
    func doneButtonAction(){
        let tooBar: UIToolbar = UIToolbar()
        tooBar.barStyle = UIBarStyle.blackOpaque
        tooBar.items=[
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action : #selector(self.donePressed))]
        tooBar.sizeToFit()
        PhnumTxtFld.inputAccessoryView = tooBar
        pincodeTxtFld.inputAccessoryView = tooBar
    }
    
    @objc func donePressed() {
        PhnumTxtFld.resignFirstResponder()
        pincodeTxtFld.resignFirstResponder()
    }
    
    func resignTheKeyboard(){
        fullNameTxtFld.resignFirstResponder()
        PhnumTxtFld.resignFirstResponder()
        pincodeTxtFld.resignFirstResponder()
        colonytxtFld.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    func validation() -> Bool{
        if(pickUpfrom.isEmpty){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Select an Address Type!!")
            return false
        } else if((fullNameTxtFld.text?.isEmpty)!){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Enter Name!!")
            return false
        } else if((PhnumTxtFld.text?.isEmpty)!){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Enter Mobile Number!!")
            return false
        } else if(PhnumTxtFld.text?.count != 10){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Enter Valid Mobile Number!!")
            return false
        } else if((pincodeTxtFld.text?.isEmpty)!){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Enter the PinCode!!")
            return false
        }else if(pincodeTxtFld.text?.count != 6){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Enter valid PinCode!!")
            return false
        } else if((colonytxtFld.text?.isEmpty)!){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Enter the Colony / Street / Locality!!")
            return false
        }else if(stateId == 0){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Select State!!")
            return false
        }else if(districtId == 0){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Select District!!")
            return false
        }else if(talkuId == 0){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Select Taluk!!")
            return false
        }else if(hobliId == 0){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Select Hobli!!")
            return false
        }else if(villageId == 0){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Select Village!!")
            return false
        }
        return true
    }
    
    func slideMenuFunc(){
        if(slideMenuStatus == true){
            sideMenuConstraints.constant = 240
            shadowView.isHidden = true
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        else {
            sideMenuConstraints.constant = 0
            shadowView.isHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        slideMenuStatus = !slideMenuStatus
    }
    
    @IBAction func addAddressBtnAction(_ sender: UIButton) {
        if(validation() == true){
            if(APIListForXohri.isInternetAvailable() == false) {
                APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Check Your Internet Connection!!!")
            }
            else {
                addNewAddress()
            }
        }
    }
    
    @IBAction func addressTypeAndStateBtnAction(_ sender: UIButton) {
        
        if(sender.tag == 2) {
            
            slideMenuFunc()
            submitBtn.isHidden = true
            getStates()
            
        } else if(sender.tag == 3) {
            
            if((selectState.titleLabel?.text == "") || (selectState.titleLabel?.text == nil)) {

                APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Select State!!")
                
            } else {
                if(stateId == 0){
                    APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Select State!!")
                }
                else{

                    slideMenuFunc()
                    submitBtn.isHidden = true
                    getDistricts()
                }
            }
            
        } else if(sender.tag == 4) {
            if((distBtn.titleLabel?.text == "") || (distBtn.titleLabel?.text == nil)) {

                APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Select District!!")
                
            } else {
                if(districtId == 0){
                    APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Select District!!")
                }
                else{

                    slideMenuFunc()
                    submitBtn.isHidden = true
                    getTaluks()
                }
            }
            
        } else if(sender.tag == 5) {
            if((talukBtn.titleLabel?.text == "") || (talukBtn.titleLabel?.text == nil)) {

                APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Select Taluk!!")
                
            } else {
                if(talkuId == 0){
                    APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Select Taluk!!")
                }
                else{

                    slideMenuFunc()
                    submitBtn.isHidden = true
                    getHoblies()
                }
            }
            
        } else if(sender.tag == 6) {
            if((hobliBtn.titleLabel?.text == "") || (hobliBtn.titleLabel?.text == nil)) {

                APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Select Hobli!!")
                
            } else {
                if(hobliId == 0){
                    APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Select Hobli!!")
                }
                else{

                    tableData = []
                    dropDownLocationTableView.reloadData()
                    slideMenuFunc()
                    submitBtn.isHidden = false
                }
            }
            
        }
        
//        resignTheKeyboard()
//        if(sender.tag == 1){
//            addrandState = ""
//            addrandState = "Address"
//            shadowView.isHidden = false
//            listTableView.reloadData()
//        }else
//            if(sender.tag == 2) {
//            addrandState = ""
//            addrandState = "State"
//            shadowView.isHidden = false
//            getStates()
//            listTableView.reloadData()
//        }
//        else if(sender.tag == 3) {
//            print("State Button text:",selectState.titleLabel?.text)
//            if((selectState.titleLabel?.text == "") || (selectState.titleLabel?.text == nil)) {
//                APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Select State!!")
//            }
//            else {
//                addrandState = ""
//                addrandState = "District"
//                if(stateId == 0){
//                    APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Select State!!")
//                }
//                else{
//                    shadowView.isHidden = false
//                    getDistricts()
//                    listTableView.reloadData()
//                }
//            }
//        }
//        else if(sender.tag == 4) {
//            print("District Button text:",distBtn.titleLabel?.text)
//            if((distBtn.titleLabel?.text == "") || (distBtn.titleLabel?.text == nil)) {
//                APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Select District!!")
//            }
//            else {
//                addrandState = ""
//                addrandState = "Taluk"
//                if(districtId == 0){
//                    APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Select District!!")
//                }
//                else{
//                    shadowView.isHidden = false
//                    getTaluks()
//                    listTableView.reloadData()
//                }
//            }
//        }
//        else if(sender.tag == 5) {
//            print("Taluk Button text:",talukBtn.titleLabel?.text)
//            if((talukBtn.titleLabel?.text == "") || (talukBtn.titleLabel?.text == nil)) {
//                APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Select Taluk!!")
//            }
//            else {
//                addrandState = ""
//                addrandState = "Hobli"
//                if(talkuId == 0){
//                    APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Select Taluk!!")
//                }
//                else{
//                    shadowView.isHidden = false
//                    getHoblies()
//                    listTableView.reloadData()
//                }
//            }
//        }
//        else if(sender.tag == 6) {
//            print("Hobli Button text:",hobliBtn.titleLabel?.text)
//            if((hobliBtn.titleLabel?.text == "") || (hobliBtn.titleLabel?.text == nil)) {
//                APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Select Hobli!!")
//            }
//            else{
//                addrandState = ""
//                addrandState = "Village"
//                if(hobliId == 0){
//                    APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Select Hobli!!")
//                }
//                else{
//                    shadowView.isHidden = false
//                    getHoblies()
//                    listTableView.reloadData()
//                }
//            }
//        }
    }
    
    @IBAction func closeBtnAction(_ sender: UIButton) {
        shadowView.isHidden = true
    }
    
    //    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
    //
    //        fullNameTxtFld.resignFirstResponder()
    //        PhnumTxtFld.resignFirstResponder()
    //        pincodeTxtFld.resignFirstResponder()
    //        flatNumTxtFld.resignFirstResponder()
    //        colonytxtFld.resignFirstResponder()
    //        landmarkTxtFld.resignFirstResponder()
    //
    //    }
}
