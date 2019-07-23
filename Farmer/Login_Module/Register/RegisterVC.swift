//
//  RegisterVC.swift
//  Farmer
//
//  Created by Apple on 11/06/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import Alamofire
import ACFloatingTextfield

class RegisterVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var regCreateAccountLbl: UILabel!
    
    @IBOutlet weak var regNameTF: ACFloatingTextField!
    @IBOutlet weak var regMobNumTF: ACFloatingTextField!
    @IBOutlet weak var regPasswordTF: ACFloatingTextField!
    @IBOutlet weak var countryCodeTF: ACFloatingTextField!
    @IBOutlet weak var regEyeBtn: UIButton!
    @IBOutlet weak var regRegisterBtn: UIButton!
    @IBOutlet weak var referralcodeBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var langBtn: UIButton!
    @IBOutlet weak var termsOfUse: UILabel!
    
    var eyeBtnArray = ["EyeWithCross_Grey.png","Eye_grey"]
    var index = 0
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        regNameTF.delegate = self
        countryCodeTF.delegate = self
        regMobNumTF.delegate = self
        regPasswordTF.delegate = self
        regPasswordTF.isSecureTextEntry = true
        countryCodeTF.text = "+91"
        countryCodeTF.isUserInteractionEnabled = false
        
        regNameTF.layer.cornerRadius = 4
        regNameTF.lineColor = UIColor.darkGray
        regNameTF.selectedLineColor = UIColor.darkGray
        regNameTF.placeHolderColor = UIColor.lightGray
        regNameTF.selectedPlaceHolderColor = UIColor.lightGray
        regNameTF.backgroundColor = UIColor.darkGray
        
        
        regMobNumTF.layer.cornerRadius = 4
        regMobNumTF.lineColor = UIColor.darkGray
        regMobNumTF.selectedLineColor = UIColor.darkGray
        regMobNumTF.placeHolderColor = UIColor.lightGray
        regMobNumTF.selectedPlaceHolderColor = UIColor.lightGray
        regMobNumTF.backgroundColor = UIColor.darkGray
        
        regPasswordTF.layer.cornerRadius = 4
        regPasswordTF.lineColor = UIColor.darkGray
        regPasswordTF.selectedLineColor = UIColor.darkGray
        regPasswordTF.placeHolderColor = UIColor.lightGray
        regPasswordTF.selectedPlaceHolderColor = UIColor.lightGray
        regPasswordTF.backgroundColor = UIColor.darkGray
        
        countryCodeTF.layer.cornerRadius = 4
        countryCodeTF.lineColor = UIColor.darkGray
        countryCodeTF.selectedLineColor = UIColor.darkGray
        countryCodeTF.placeHolderColor = UIColor.lightGray
        countryCodeTF.selectedPlaceHolderColor = UIColor.lightGray
        countryCodeTF.backgroundColor = UIColor.darkGray
        
        langBtn.layer.borderColor = UIColor.lightGray.cgColor
        langBtn.layer.borderWidth = 1
        langBtn.layer.cornerRadius = 5
        
        regRegisterBtn.backgroundColor = UIColor.red
        regRegisterBtn.layer.cornerRadius = 5
    
    }
    
    func doneButtonAction(){
        let tooBar: UIToolbar = UIToolbar()
        tooBar.barStyle = UIBarStyle.default
        tooBar.items=[
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action : #selector(self.donePressed))]
        tooBar.sizeToFit()
        regMobNumTF.inputAccessoryView = tooBar
    }
    //TO RESIGN NUMERIC KEYBOARD
    @objc func donePressed () {
        regMobNumTF.resignFirstResponder()
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.clearsOnBeginEditing = false
            if(textField == regNameTF){
                
            }
            else if(textField == regPasswordTF){
                textField.clearsOnBeginEditing = false
//                moveTextField(textField, moveDistance: 100, up: false)
            }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if (string == " ") {
//            return false
//        }
        if(textField == regNameTF){
            print("textField.text:",textField.text)
            if(textField == regNameTF){
                if((textField.text?.count)! >= 25){
                    if(string == ""){
                        return true
                    }
                    else{
                        APIListForXohri.showAlertMessage(vc: self, messageStr: "Name can contain maximum 25 characters!!")
                        return false
                    }
                    
                }
                else{
                    if(string.isInt){
                        return false
                    }
                }
            }
            
            if(string == " "){
                if(textField.text?.last == " "){
                    // APIListForXohri.showAlertMessage(vc: self, messageStr: "Name should not contain space")
                    return false
                }
                if(textField.text?.isEmpty == true){
                    return false
                }
                if(textField.text?.last != " "){
                    return true
                }
                return false
            }
            return true
        }
        
        
        if(textField == regMobNumTF){
            let enteredStr : NSString = string as NSString
            let tfValue : NSString = textField.text! as NSString
                if((textField.text?.count)! < 10){
                    let newString : NSString = tfValue.replacingOccurrences(of: enteredStr as String, with: tfValue as String) as NSString
                }
                else {
                    if(string == ""){
                        return true
                    }
                    regPasswordTF.becomeFirstResponder()
                    return false
                }
            
        }
        if(textField == regPasswordTF){
            if((textField.text?.count)! > 11){
                
                    APIListForXohri.showAlertMessage(vc: self, messageStr: "Password can have maximum of 12 characters!!")
                    return false
                
            }
            if(string == " "){
                APIListForXohri.showAlertMessage(vc: self, messageStr: "Password should not contain space!")
                
                return false
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
            if(textField == regNameTF){
                if(validateName(textField: textField.text!) == true){
                    if(!(regNameTF.text?.isEmpty)!){
                        if((regNameTF.text?.count)! < 2){
                            APIListForXohri.showAlertMessage(vc: self, messageStr: "Name should contain atleast 2 characters!!")
                        }
                        regMobNumTF.becomeFirstResponder()
                    }
                }
                else{
                    APIListForXohri.showAlertMessage(vc: self, messageStr: "Please enter valid name!!")
                }
            }
            else if(textField == regPasswordTF){
                if((textField.text?.count)! < 6){
//                    moveTextField(textField, moveDistance: -100, up: false)
                    APIListForXohri.showAlertMessage(vc: self, messageStr: "Password should contain atleast 6 characters!!")
                }
                else if((textField.text?.count)! > 12){
//                    moveTextField(textField, moveDistance: -100, up: false)
                    APIListForXohri.showAlertMessage(vc: self, messageStr: "Password can contain 12 characters!!")
                }
                else{
//                    moveTextField(textField, moveDistance: -100, up: false)
                }
            }
        
    }
    
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    func validateName(textField : String) -> Bool {
        var returnValue = true
        let mobileRegEx =  "^[a-zA-Z ]*${3}"  // {3} -> at least 3 alphabet are compulsory.
        do {
            let regex = try NSRegularExpression(pattern: mobileRegEx)
            let nsString = textField as NSString
            let results = regex.matches(in: textField, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
        }
        catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return  returnValue
    }
    
    func validate() -> Bool {
        if(!(regNameTF.text?.isEmpty)!){
            if((regNameTF.text?.count)! < 2){
                APIListForXohri.showAlertMessage(vc: self, messageStr: "Name should contain atleast 2 characters!!")
                return false
            }
        }
        else if((countryCodeTF.text?.isEmpty)!){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please select the country code!!")
            return false
        }
        else if (validateName(textField: regNameTF.text!) ==  false){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Enter Valid Name")
            return false
        }
        if(regMobNumTF.text?.count != 10){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Enter Valid Mobile Number")
            return false
        }
        if((regPasswordTF.text?.count)! < 6){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Password Should Contain Atleast 6 Characters!!")
            return false
        }
        else if((regPasswordTF.text?.count)! > 12){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Password Can Have Maximum Of 12 Characters!!")
            return false
        }
        return true
    }
    
    
    //PASSWORD FORMATE VALIDATION.
    func validatePassword(testStr:String) -> Bool {
        if(testStr.count < 6) {
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Password Should Contain Atleast 6 Characters")
            return false
        }
        return true
    }
    
    
    func registerCustomer(){
        APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: UIActivityIndicatorView.Style.gray)
        self.view.isUserInteractionEnabled = false
        
        let data : NSDictionary = [ "PhoneNo":countryCodeTF.text! + regMobNumTF.text!,
                                    "DeviceId":UIDevice.current.identifierForVendor?.uuidString,
                                    "DeviceType":"iOS",
                                    "FullName":regNameTF.text!,
                                    "EmailId":"",
                                    "CountryId":0,
                                    "StateId":0,
                                    "DistrictId":0,
                                    "TalukId":0,
                                    "HobliId":0,
                                    "Password":regPasswordTF.text!
        ]
        let param = ["objUser": data]
        
        Alamofire.request(APIListForXohri.registerCustomer, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response:DataResponse<Any>) in
            switch(response.result){
                
            case .success(_):
                
                print("Printing response in register page:",response.result.value!)
                
                let response = response.result.value as? NSDictionary
                
                print("printing the output data when user register: ", response!)
                
                if let msg = response?.value(forKey: "Message"){
                    APIListForXohri.hideActivityIndicator()
                    self.view.isUserInteractionEnabled = true
                    print("Something wrong in Registration service call:",msg)
                    
                    
                } else {
                    
                    let Resp = response?.value(forKey: "Response") as! NSDictionary
                    let statusMsg = Resp.value(forKey: "Message") as! String
                    let status = Resp.value(forKey: "Status") as! Int
                    let userDetails = response?.value(forKey: "user") as? NSDictionary
                    
                    ForgotPasswordVC.PhNumStatus = 2
                    if let nameOfRegisteredUser = userDetails?.value(forKey: "FullName") as? String  {
                        UserDefaults.standard.set(nameOfRegisteredUser, forKey: "UserName1st")
                        print("Printing the name of the user: ", UserDefaults.standard.string(forKey: "UserName1st")!)
                    }
                    
                    if let phNoOfRegisterUser = userDetails?.value(forKey: "PhoneNo") as? String  {
                        UserDefaults.standard.set(phNoOfRegisterUser, forKey: "UserPhoneNumber1st")
                        print("Printing the phoneNumber of the user: ", UserDefaults.standard.string(forKey: "UserPhoneNumber1st")!)
                    }
                    
                    if let emailIfOfRegisterUser = userDetails?.value(forKey: "EmailId") as? String  {
                        UserDefaults.standard.set(emailIfOfRegisterUser, forKey: "UserEmailID1st")
                        print("Printing the EmailID of the user: ", UserDefaults.standard.string(forKey: "UserEmailID1st")!)
                    }
                    if let userID = userDetails?.value(forKey: "Id") as? Int {
                        UserDefaults.standard.set(userID, forKey: "UserID1st")
                    }
                    if(status == 1) {
                        let userDetails = response?.value(forKey: "user") as! NSDictionary
                        LoginVC.userInfo.setValue((userDetails as AnyObject).value(forKey: "OTP") as? String, forKey: "otp")
                        LoginVC.userInfo.setValue(self.countryCodeTF.text! + self.regMobNumTF.text!, forKey: "UserPhoneNum")
                        APIListForXohri.showToast(view: self.view, message: statusMsg)
                    }
                    else {
                        APIListForXohri.showAlertMessage(vc: self, messageStr: statusMsg)
                    }
                    APIListForXohri.hideActivityIndicator()
                    self.view.isUserInteractionEnabled = true
                    self.navigate()
                }
                
            case .failure(_):
                break
                
                self.view.isUserInteractionEnabled = true
                APIListForXohri.hideActivityIndicator()
                
            }
        }
    }
    
    func navigate(){
        APIListForXohri.hideActivityIndicator()
        self.view.isUserInteractionEnabled = true
        performSegue(withIdentifier: "RegisterVCToOtp", sender: self)
    }
  
    @IBAction func registerEyeBtnAction(_ sender: UIButton) {
        self.index = (self.index >= self.eyeBtnArray.count-1) ? 0 : self.index+1
        sender.setImage(UIImage(named:eyeBtnArray[index]), for: .normal)
        if(index == 0){
            regPasswordTF.isSecureTextEntry = true
        }
        else{
            regPasswordTF.isSecureTextEntry = false
        }
    }
    @IBAction func registerBtnAction(_ sender: UIButton) {
        if(validate() == true){
            if(APIListForXohri.isInternetAvailable() ==  false){
                APIListForXohri.showAlertMessage(vc: self, messageStr: "Please check your Internet Connection!!!")
            }
            else{
                APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: .gray)
                self.view.isUserInteractionEnabled = false
                registerCustomer()
            }
        }
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
      
        regNameTF.resignFirstResponder()
        regMobNumTF.resignFirstResponder()
        regPasswordTF.resignFirstResponder()
        
    }
    @IBAction func referralCodeBtnAction(_ sender: UIButton) {
    }
    
    @IBAction func loginBtnAction(_ sender: UIButton) {
//        performSegue(withIdentifier: "signUpToLoginPage", sender: self)
    }
    @IBAction func cancelBtnAction(_ sender: UIButton) {
//        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "signUpToLoginPage", sender: self)

    }
    @IBAction func langBtnAction(_ sender: UIButton) {
        performSegue(withIdentifier: "registerToSelectLang", sender: self)
    }
    @IBAction func termsAndPoliciesBtnAction(_ sender: UIButton) {
        performSegue(withIdentifier: "privacyPolicyTermsOfUse", sender: self)
    }
}


