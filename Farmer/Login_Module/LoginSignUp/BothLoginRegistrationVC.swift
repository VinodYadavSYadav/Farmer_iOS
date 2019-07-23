//
//  BothLoginRegistrationVC.swift
//  Xohri
//
//  Created by Apple on 13/02/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import Alamofire
import SQLite3
import ACFloatingTextfield

class BothLoginRegistrationVC: UIViewController,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var xohriLBL: UILabel!
    @IBOutlet weak var signinRegister: UISegmentedControl!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var registerView: UIView!
    
    //Login View Outlets
    @IBOutlet weak var loginWelcomeLabel: UILabel!
    @IBOutlet weak var loginMobNumTF: ACFloatingTextField!
    @IBOutlet weak var loginPasswordTF: ACFloatingTextField!
    @IBOutlet weak var loginRegNumLabel: UILabel!
    @IBOutlet weak var loginDropDownTableView: UITableView!
    @IBOutlet weak var loginRememberMeBtn: UIButton!
    @IBOutlet weak var loginForgotPassWordBtn: UIButton!
    @IBOutlet weak var loginEyeBtn: UIButton!
    @IBOutlet weak var loginLoginBtn: UIButton!
    @IBOutlet weak var loginRegNumView: UIView!
    
    //Register View Outlets
    @IBOutlet weak var regCreateAccountLbl: UILabel!
    @IBOutlet weak var regNameTF: ACFloatingTextField!
    @IBOutlet weak var regRegNumLabel: UILabel!
    @IBOutlet weak var regMobNumTF: ACFloatingTextField!
    @IBOutlet weak var regPasswordTF: ACFloatingTextField!
    @IBOutlet weak var regDropDownTableView: UITableView!
    @IBOutlet weak var regEyeBtn: UIButton!
    @IBOutlet weak var regRegisterBtn: UIButton!
    @IBOutlet weak var regRegNumView: UIView!
    
    var statement: OpaquePointer?
    var pass :String? = ""
    private var currentTextField: UITextField?
    
    var dataDict = NSDictionary()
    var eyeBtnArray = ["EyeWithCross_Grey.png","Eye_grey"]
    var index = 0
    
    static var userInfon = NSMutableDictionary()
    
    var isAutoLogin = Bool()
    
    var dropDownList = [ "+91"]
    var statusOfLogin = NSDictionary()
    var userDetails = NSDictionary()
    static var phoneNumber = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
//        let recovedUserJsonData = UserDefaults.standard.object(forKey: "DataInDiffLang")
//        dataDict = NSKeyedUnarchiver.unarchiveObject(with: recovedUserJsonData as! Data) as! NSDictionary
        
//        signinRegister.addUnderlineForSelectedSegment()
        
        registerView.isHidden = true
        loginRegNumView.isHidden = true
        regRegNumView.isHidden = true
        loginRegNumView.layer.borderColor = UIColor.lightGray.cgColor
        loginRegNumView.layer.borderWidth = 1
        loginRegNumView.layer.cornerRadius = 1
        regRegNumView.layer.borderColor = UIColor.lightGray.cgColor
        regRegNumView.layer.borderWidth = 1
        regRegNumView.layer.cornerRadius = 1
        
        //Login
        loginView.isHidden = false
        loginMobNumTF.delegate = self
        loginPasswordTF.delegate = self
        
        //Register
        regNameTF.delegate = self
        regMobNumTF.delegate = self
        regPasswordTF.delegate = self
        
        regNameTF.lineColor = UIColor(red:0.54, green:0.55, blue:0.57, alpha:1.0)
        regNameTF.selectedLineColor = UIColor(red:0.13, green:0.14, blue:0.18, alpha:1.0)
        regNameTF.placeHolderColor = UIColor(red:0.54, green:0.55, blue:0.57, alpha:1.0)
        regNameTF.selectedPlaceHolderColor = UIColor(red:0.13, green:0.14, blue:0.18, alpha:1.0)
        
        regMobNumTF.lineColor = UIColor(red:0.54, green:0.55, blue:0.57, alpha:1.0)
        regMobNumTF.selectedLineColor = UIColor(red:0.13, green:0.14, blue:0.18, alpha:1.0)
        regMobNumTF.placeHolderColor = UIColor(red:0.54, green:0.55, blue:0.57, alpha:1.0)
        regMobNumTF.selectedPlaceHolderColor = UIColor(red:0.13, green:0.14, blue:0.18, alpha:1.0)
        
        regPasswordTF.lineColor = UIColor(red:0.54, green:0.55, blue:0.57, alpha:1.0)
        regPasswordTF.selectedLineColor = UIColor(red:0.13, green:0.14, blue:0.18, alpha:1.0)
        regPasswordTF.placeHolderColor = UIColor(red:0.54, green:0.55, blue:0.57, alpha:1.0)
        regPasswordTF.selectedPlaceHolderColor = UIColor(red:0.13, green:0.14, blue:0.18, alpha:1.0)
        
        loginMobNumTF.lineColor = UIColor(red:0.54, green:0.55, blue:0.57, alpha:1.0)
        loginMobNumTF.selectedLineColor = UIColor(red:0.13, green:0.14, blue:0.18, alpha:1.0)
        loginMobNumTF.placeHolderColor = UIColor(red:0.54, green:0.55, blue:0.57, alpha:1.0)
        loginMobNumTF.selectedPlaceHolderColor = UIColor(red:0.13, green:0.14, blue:0.18, alpha:1.0)
        
        loginPasswordTF.lineColor = UIColor(red:0.54, green:0.55, blue:0.57, alpha:1.0)
        loginPasswordTF.selectedLineColor = UIColor(red:0.13, green:0.14, blue:0.18, alpha:1.0)
        loginPasswordTF.placeHolderColor = UIColor(red:0.54, green:0.55, blue:0.57, alpha:1.0)
        loginPasswordTF.selectedPlaceHolderColor = UIColor(red:0.13, green:0.14, blue:0.18, alpha:1.0)
        
        loginPasswordTF.isSecureTextEntry = true
        regPasswordTF.isSecureTextEntry = true
        
        loginLoginBtn.layer.cornerRadius = 5
        loginLoginBtn.backgroundColor = UIColor(red:1.00, green:0.17, blue:0.33, alpha:1.0)
        
        regRegisterBtn.layer.cornerRadius = 5
        regRegisterBtn.backgroundColor = UIColor(red:1.00, green:0.17, blue:0.33, alpha:1.0)
        
        if let signIn = dataDict.value(forKey: "Login") as? String {
            signinRegister.setTitle(signIn , forSegmentAt: 0)
        }
        
        if let signUp = dataDict.value(forKey: "Register") as? String {
            signinRegister.setTitle(signUp , forSegmentAt: 1)
        }
        
        if let createAccount = dataDict.value(forKey: "CreateAccount") as? String {
            regCreateAccountLbl.text = createAccount
        }
        
        if let namePlaceHolder = dataDict.value(forKey: "FullName") as? String {
            regNameTF.placeholder = namePlaceHolder
        }
        
        if let passPlaceHolder = dataDict.value(forKey: "EnterPhoneNo") as? String {
            regMobNumTF.placeholder = passPlaceHolder
        }
        
        if let passPlaceHolder = dataDict.value(forKey: "EnterPassword") as? String {
            regPasswordTF.placeholder = passPlaceHolder
        }
        
        if let registerBtnTxt = dataDict.value(forKey: "Register") as? String {
            regRegisterBtn.setTitle(registerBtnTxt, for: .normal)
        }
        
        if let welcomeBackTxtLbl = dataDict.value(forKey: "WelcomeBack") as? String {
            loginWelcomeLabel.text = welcomeBackTxtLbl
        }
        
        if let phNoPlaceHolder = dataDict.value(forKey: "EnterPhoneNo") as? String {
            loginMobNumTF.placeholder = phNoPlaceHolder
        }
        
        if let passPlaceHolder = dataDict.value(forKey: "EnterPassword") as? String {
            loginPasswordTF.placeholder = passPlaceHolder
        }
        
        if let remeberMeBtnTxt = dataDict.value(forKey: "RememberMe") as? String {
            loginRememberMeBtn.setTitle(remeberMeBtnTxt, for: .normal)
        }
        
        if let forgotPassBtnTxt = dataDict.value(forKey: "ForgotPassword") as? String {
            loginForgotPassWordBtn.setTitle(forgotPassBtnTxt + "?", for: .normal)
        }
        
        if let loginBtnTxt = dataDict.value(forKey: "Login") as? String {
            loginLoginBtn.setTitle(loginBtnTxt, for: .normal)
        }
        doneButtonAction()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLabel))
        regRegNumLabel.isUserInteractionEnabled = true
        regRegNumLabel.addGestureRecognizer(tap)
        
        let tapLogin = UITapGestureRecognizer(target: self, action: #selector(tapLoginLabel))
        loginRegNumLabel.isUserInteractionEnabled = true
        loginRegNumLabel.addGestureRecognizer(tapLogin)
    }
    
    func doneButtonAction(){
        let tooBar: UIToolbar = UIToolbar()
        tooBar.barStyle = UIBarStyle.default
        tooBar.items=[
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action : #selector(self.donePressed))]
        tooBar.sizeToFit()
        loginMobNumTF.inputAccessoryView = tooBar
        regMobNumTF.inputAccessoryView = tooBar
    }
    
    @objc func tapLabel(sender : UITapGestureRecognizer){
        if(regRegNumView.isHidden == true){
            regRegNumView.isHidden = false
        }
        else{
            regRegNumView.isHidden = true
        }
    }
    
    @objc func tapLoginLabel(sender : UITapGestureRecognizer){
        if(loginRegNumView.isHidden == true){
            loginRegNumView.isHidden = false
        }
        else{
            loginRegNumView.isHidden = true
        }
    }
    
    
    //TO RESIGN NUMERIC KEYBOARD
    @objc func donePressed () {
        if(registerView.isHidden != true) {
            regMobNumTF.resignFirstResponder()//mobileNumberSignUp
        } else if(loginView.isHidden != true) {
            loginMobNumTF.resignFirstResponder()
        }
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView == regDropDownTableView){
            regRegNumLabel.text = dropDownList[indexPath.row]
            regRegNumView.isHidden = true
        }
        if(tableView == loginDropDownTableView){
            loginRegNumLabel.text = dropDownList[indexPath.row]
            loginRegNumView.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == regDropDownTableView){
            let cell = regDropDownTableView.dequeueReusableCell(withIdentifier: "regCell", for: indexPath) as! registerTableViewCell
            cell.regCountryCodeLabel.text = dropDownList[indexPath.row]
            return cell
        }
        else{
            let cell = loginDropDownTableView.dequeueReusableCell(withIdentifier: "loginCell", for: indexPath) as! loginTableViewCell
            cell.loginCountryCodeLabel.text = dropDownList[indexPath.row]
            return cell
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.clearsOnBeginEditing = false
        if(registerView.isHidden != true ) {
            if(textField == regNameTF){
                
            }
                //            else if(textField == regDropDropTF){
                //                regDropDropTF.resignFirstResponder()
                //                regRegNumView.isHidden = false
                //                regDropDownTableView.reloadData()
                //            }
            else if(textField == regPasswordTF){
                textField.clearsOnBeginEditing = false
                moveTextField(textField, moveDistance: 100, up: false)
            }
        }
        else if(loginView.isHidden != true) {
            //            if(textField == loginDropDownTF) {
            //                registerView.isHidden = true
            //                loginRegNumView.isHidden = false
            //                loginDropDownTableView.reloadData()
            //                loginDropDownTF.resignFirstResponder()
            //            }
            if(textField == loginPasswordTF){
                moveTextField(textField, moveDistance: 50, up: false)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == regNameTF){
        if(string == " "){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Name should not contain space")
            return false
        }
             return true
        }
        if(textField == regNameTF){
            if((textField.text?.count)! >= 25){
                return false
            }
            else{
                if(string.isInt){
                    return false
                }
            }
        }
        
        if(textField == regMobNumTF){
            let enteredStr : NSString = string as NSString
            let tfValue : NSString = textField.text! as NSString
            if(registerView.isHidden != true){
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
        }
        if(textField == regPasswordTF){
            if((textField.text?.count)! > 11){
                if(string == "" ){
                    return true
                }
                APIListForXohri.showAlertMessage(vc: self, messageStr: "Password can have maximum of 12 characters!!")
                return false
            }
        }
        if(loginView.isHidden != true) {
            if(textField == loginMobNumTF){
                let maxLength = 10
                let currentString: NSString = textField.text! as NSString
                let newString: String = currentString.replacingCharacters(in: range, with: string) as String
                
                if(newString.count < 10) {
                    loginRememberMeBtn.isSelected = false
                    loginRememberMeBtn.setImage(UIImage(named: "icons8-unchecked-checkbox-filled-50"), for: .normal)
                    pass = ""
                    loginPasswordTF.text = ""
                }
                if (newString.count == 10) {
                    
                    loginMobNumTF.text = newString//phoneNumberTxtFld.text!
                    
                    if sqlite3_prepare_v2(AppDelegate.db, "select * from users_details where phonenumber = '\(loginMobNumTF.text)'", -1, &statement, nil) != SQLITE_OK {
                        
                        let errmsg = String(cString: sqlite3_errmsg(AppDelegate.db)!)
                        
                        print("error preparing select in LogInPage: \(errmsg)")
                        
                    }
                    while sqlite3_step(statement) == SQLITE_ROW {
                        
                        if let cString = sqlite3_column_text(statement, 2) {
                            
                            pass = String(cString: cString)
                            
                            print("pass = \(pass)")
                            
                            
                        }
                        
                    }
                    
                    if sqlite3_finalize(statement) != SQLITE_OK {
                        
                        let errmsg = String(cString: sqlite3_errmsg(AppDelegate.db)!)
                        
                        print("error finalizing prepared statement in LogInPage: \(errmsg)")
                        
                    }
                    
                    statement = nil
                    
                    if (pass == "") {
                        print("Printing Nothing")
                    } else {
                        loginRememberMeBtn.setImage(UIImage(named: "icons8-checked-checkbox-filled-50 (1)"), for: .normal)
                        loginPasswordTF.text = pass
                    }
                    
                    loginMobNumTF.text = newString
                    loginPasswordTF.becomeFirstResponder()
                    return newString.count <= maxLength
                }
                else{
                    return newString.count <= maxLength
                }
            }
            
            if(textField == loginPasswordTF){
                let currentString: NSString = textField.text! as NSString
                var newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
                
                if(newString.contains(" ")) {
                    newString.replacingOccurrences(of: " ", with: "")
                    return false
                }
                if(newString.length > 12) {
                    newString = newString.replacingCharacters(in: range, with: string) as NSString
                    return newString.length <= 12
                }
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(registerView.isHidden != true ) {
            
            if(textField == regNameTF){
                if(validateName(textField: textField.text!) == true){
                    if((regNameTF.text?.count)! < 2){
                        APIListForXohri.showAlertMessage(vc: self, messageStr: "Name should contain atleast 2 characters!!")
                    }
                    regMobNumTF.becomeFirstResponder()
                }
                else{
                    APIListForXohri.showAlertMessage(vc: self, messageStr: "Please enter valid name!!")
                }
            }
            else if(textField == regPasswordTF){
                if((textField.text?.count)! < 6){
                    moveTextField(textField, moveDistance: -100, up: false)
                    APIListForXohri.showAlertMessage(vc: self, messageStr: "Password should contain atleast 6 characters!!")
                }
                else if((textField.text?.count)! > 12){
                    moveTextField(textField, moveDistance: -100, up: false)
                    APIListForXohri.showAlertMessage(vc: self, messageStr: "Password can contain 12 characters!!")
                }
                else{
                    moveTextField(textField, moveDistance: -100, up: false)
                }
            }
            //            else if(textField == regDropDropTF){
            //                regRegNumView.isHidden = true
            //            }
        }
        else  if(loginView.isHidden != true ) {
            //            if(textField == loginDropDownTF) {
            //                loginDropDownTF.resignFirstResponder()
            //            }
            if(textField == loginPasswordTF){
                moveTextField(textField, moveDistance: -50, up: false)
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
        if((regNameTF.text?.isEmpty)!){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Enter your Name")
            return false
        }
        else if((regNameTF.text?.count)! < 2){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Name should contain atleast 2 characters!!")
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
    
    //VALIDATING TEXTFIELD WITH 10DIGITS AND CORRECT PASSWORD.
    func validateTextFields() -> Bool {
        if (loginMobNumTF.text?.count != 10){
            loginMobNumTF.text  = ""
            APIListForXohri.showAlertMessage(vc: self, messageStr: "You Have Entered Incorrect Number, Please Enter Valid 10 digit Mobile Number")
            return false
        }
        if validatePassword(testStr: loginPasswordTF.text!) == false{
            loginPasswordTF.text = ""
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Password Should Contain Atleast 6 Characters")
            return false
        }
        else {
            if(APIListForXohri.isInternetAvailable() == false){
                APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Check Your Internet Connection!!!")
            }
            else{
                if(APIListForXohri.isInternetAvailable() == false){
                    self.view.isUserInteractionEnabled = true
                    APIListForXohri.hideActivityIndicator()
                    APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Check Your Internet Connection!!!")
                }
                else{
                    loginPageFunc()
                }
            }
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
    
    //Registration Function
    func registerCustomer(){
        
        
        APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: UIActivityIndicatorView.Style.gray)
        self.view.isUserInteractionEnabled = false
        
        let data : NSDictionary = [ "PhoneNo":regRegNumLabel.text! + regMobNumTF.text!,
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
                
                print("Printing response in register page:",response.result.value)
                
                let response = response.result.value as? NSDictionary
                
                print("printing the output data when user register: ", response)
                
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
                    
                    
                    if(status == 1) {
                        let userDetails = response?.value(forKey: "user") as! NSDictionary
                        BothLoginRegistrationVC.userInfon.setValue((userDetails as AnyObject).value(forKey: "OTP") as? String, forKey: "otp")
                        
                        BothLoginRegistrationVC.userInfon.setValue(self.regMobNumTF.text!, forKey: "UserPhoneNum")
                        
                        
                        APIListForXohri.showToast(view: self.view, message: statusMsg)
                    } else {
                        APIListForXohri.showAlertMessage(vc: self, messageStr: statusMsg)
                    }
                    
                    
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
        performSegue(withIdentifier: "RegisterPageToOTP", sender: self)
    }
    
    //Login Function
    func loginPageFunc() {
        
        APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: UIActivityIndicatorView.Style.gray)
        self.view.isUserInteractionEnabled = false
        let loginParam : NSDictionary = ["UserName": loginRegNumLabel.text! + loginMobNumTF.text!,"Password": loginPasswordTF.text!]
        let Param = ["UserRequest" :loginParam]
        
        Alamofire.request(APIListForXohri.login, method: .post, parameters: Param, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success:
                if let data = response.result.value {
                    let jsonData = data as! NSDictionary
                     print("printing the output data when user login: ", jsonData)
                    
                    if let message: String = jsonData.value(forKey: "Message") as? String {
                        
                        self.view.isUserInteractionEnabled = true
                        APIListForXohri.hideActivityIndicator()
                        print("Something Went Wrong!!",message)
                        
                    } else {
                        ForgotPasswordVC.PhNumStatus = 3
                        self.statusOfLogin = (jsonData.value(forKey: "ResultObject") as? NSDictionary)!
                       
                        
                        let status = (self.statusOfLogin.value(forKey: "Status") as? Int)!
                        print("Printing the status: ",status)
                        let statusMsg = self.statusOfLogin.value(forKey: "Message") as? String ?? ""

                        if(status != 1) {
                            
                            self.isAutoLogin = false
                            APIListForXohri.showAlertMessage(vc: self, messageStr: statusMsg)
                            APIListForXohri.hideActivityIndicator()
                            self.view.isUserInteractionEnabled = true
                            
                        }  else {
                            
                            BothLoginRegistrationVC.userInfon.setValue(self.loginMobNumTF.text!, forKey: "UserPhoneNum")
                            
                            self.userDetails = (self.statusOfLogin.value(forKey: "user") as? NSDictionary)!
                            
                            if let userID = self.userDetails.value(forKey: "Id") as? Int {
                                UserDefaults.standard.set(userID, forKey: "UserId")
                            }
                            
                            if let nameOfUser = self.userDetails.value(forKey: "FullName") as? String {
                                UserDefaults.standard.set(nameOfUser, forKey: "UserName")
                                print("Printing the name of the user when user Login: ", UserDefaults.standard.string(forKey: "UserName"))
                            }
                            
                            if let PhNumOfUser = self.userDetails.value(forKey: "PhoneNo") as? String {
                                UserDefaults.standard.set(PhNumOfUser, forKey: "UserPhoneNum")
                            }
                            
                            UserDefaults.standard.synchronize()
                          
                            APIListForXohri.hideActivityIndicator()
                            self.view.isUserInteractionEnabled = true
                            self.performSegue(withIdentifier: "signUpToHome", sender: self)
                            
                        }
                    }
                }
                break
                
            case .failure:
                APIListForXohri.hideActivityIndicator()
                self.view.isUserInteractionEnabled = true
                break
            }
        }
    }
    
    @IBAction func forgetPasswordAction(_ sender: UIButton) {
        performSegue(withIdentifier: "loginToForgotPassword", sender: self)
    }
    
    @IBAction func rememberMeAction(_ sender: UIButton) {
        if let currentTextField = currentTextField {
            moveTextField(loginPasswordTF, moveDistance: 100, up: false)
            
            //currentTextField.resignFirstResponder()
        }
        
        if (sender.isSelected == true){
            sender.isSelected = false;
            isAutoLogin = false
        }
        else {
            isAutoLogin = true
            print("Clicked true for remember me!!")
            sender.isSelected = true;
        }
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
    
    @IBAction func loginEyeBtnAction(_ sender: UIButton) {
        self.index = (self.index >= self.eyeBtnArray.count-1) ? 0 : self.index+1
        sender.setImage(UIImage(named:eyeBtnArray[index]), for: .normal)
        
        if(index == 0){
            loginPasswordTF.isSecureTextEntry = true
        } else {
            loginPasswordTF.isSecureTextEntry = false
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
    
    @IBAction func loginBtnAction(_ sender: UIButton) {
        if ( loginMobNumTF.text == "" || loginMobNumTF.text == nil  ){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "All Fields Are Required To Fill In")
            return
        }
        if (validateTextFields()){
            print("Working")
        }
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        if(registerView.isHidden != true){
            regRegNumView.isHidden = true
        }
        else if(loginView.isHidden != true){
            loginRegNumView.isHidden = true
        }
        regNameTF.resignFirstResponder()
        regMobNumTF.resignFirstResponder()
        regPasswordTF.resignFirstResponder()
        
        loginMobNumTF.resignFirstResponder()
        loginPasswordTF.resignFirstResponder()
    }
    
    @IBAction func actionSigninRegister(_ sender: UISegmentedControl) {
//        signinRegister.changeUnderlinePosition()
        switch signinRegister.selectedSegmentIndex {
        case 0:
            loginView.isHidden = false
            registerView.isHidden = true
            //            regNameTF.resignFirstResponder()
            //            regMobNumTF.resignFirstResponder()
            //            regPasswordTF.resignFirstResponder()
            
        case 1:
            loginView.isHidden = true
            registerView.isHidden = false
            //            loginMobNumTF.resignFirstResponder()
            //            loginPasswordTF.resignFirstResponder()
            
        default:
            break;
        }
    }
    
}

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}



extension UIImage{
    class func getColoredRectImageWith(color: CGColor, andSize size: CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let graphicsContext = UIGraphicsGetCurrentContext()
        graphicsContext?.setFillColor(color)
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        graphicsContext?.fill(rectangle)
        let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rectangleImage!
    }
}
