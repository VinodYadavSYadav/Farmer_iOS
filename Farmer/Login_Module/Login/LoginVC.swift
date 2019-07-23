
//
//  LoginVC.swift
//  Farmer
//
//  Created by Apple on 11/06/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import Alamofire
import ACFloatingTextfield

class LoginVC: UIViewController, UITextFieldDelegate, varietyOfLang {
    
    @IBOutlet weak var xohriImage: UIImageView!
    @IBOutlet weak var loginTxtLbll: UILabel!
    @IBOutlet weak var loginMobNumTF: ACFloatingTextField!
    @IBOutlet weak var loginPasswordTF: ACFloatingTextField!
    @IBOutlet weak var loginRememberMeBtn: UIButton!
    @IBOutlet weak var loginForgotPassWordBtn: UIButton!
    @IBOutlet weak var loginEyeBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var createAccountBtn: UIButton!
    @IBOutlet weak var languageLbl: UILabel!
    @IBOutlet weak var langBtn: UIButton!
    
    var eyeBtnArray = ["EyeWithCross_Grey.png","Eye_grey"]
    var index = 0
    
    var statusOfLogin = NSDictionary()
    var userDetails = NSDictionary()
    static var userInfo = NSMutableDictionary()
    var dataDict : NSDictionary? =  nil

    
    private var currentTextField: UITextField?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginMobNumTF.keyboardType = .asciiCapableNumberPad
        loginPasswordTF.keyboardType = .asciiCapable
        
        loginMobNumTF.delegate = self
        loginPasswordTF.delegate =  self
        loginPasswordTF.isSecureTextEntry = true
        
        loginBtn.backgroundColor = UIColor.black
        loginBtn.layer.borderColor = UIColor.lightGray.cgColor
        loginBtn.layer.borderWidth = 1
        loginBtn.layer.cornerRadius = 5
        loginForgotPassWordBtn.tintColor = UIColor(red:0.02, green:0.29, blue:0.56, alpha:1.0)
        
        langBtn.layer.borderColor = UIColor.lightGray.cgColor
        langBtn.layer.borderWidth = 1
        langBtn.layer.cornerRadius = 5
        
        loginMobNumTF.layer.cornerRadius = 4
        loginMobNumTF.lineColor = UIColor.darkGray
        loginMobNumTF.selectedLineColor = UIColor.darkGray
        loginMobNumTF.placeHolderColor = UIColor.lightGray
        loginMobNumTF.selectedPlaceHolderColor = UIColor.lightGray
        loginMobNumTF.backgroundColor = UIColor.darkGray
        
        loginPasswordTF.layer.cornerRadius = 4
        loginPasswordTF.lineColor = UIColor.darkGray
        loginPasswordTF.selectedLineColor = UIColor.darkGray
        loginPasswordTF.placeHolderColor = UIColor.lightGray
        loginPasswordTF.selectedPlaceHolderColor = UIColor.lightGray
        loginPasswordTF.backgroundColor = UIColor.darkGray
      
    }
    
   
    func languageSelection() {
        
        if(SelectLanguageVC.statusOfSelectedLang == 1) {
            
            print("Prints when this function is called")
            let abjhdbc = UserDefaults.standard.dictionary(forKey: "DataInDiffLang")
            print("Printing the values present in that dictionary: ",abjhdbc)
            
            let recovedUserJsonData = UserDefaults.standard.object(forKey: "DataInDiffLang")
            dataDict = NSKeyedUnarchiver.unarchiveObject(with: recovedUserJsonData as! Data) as! NSDictionary
            
            if let loginTxt = dataDict?.value(forKey: "Login") as? String {
                loginTxtLbll.text = loginTxt
            }
            
            if let phNoPlaceHolder = dataDict?.value(forKey: "EnterPhoneNo") as? String {
                loginMobNumTF.placeholder = phNoPlaceHolder
            }
            
            if let passPlaceHolder = dataDict?.value(forKey: "EnterPassword") as? String {
                loginPasswordTF.placeholder = passPlaceHolder
            }
            
            //        if let remeberMeBtnTxt = dataDict.value(forKey: "RememberMe") as? String {
            //            rememberMe.setTitle(remeberMeBtnTxt, for: .normal)
            //        }
            
            if let forgotPassBtnTxt = dataDict?.value(forKey: "ForgotPassword") as? String {
                loginForgotPassWordBtn.setTitle(forgotPassBtnTxt + "?", for: .normal)
            }
            
            if let loginBtnTxt = dataDict?.value(forKey: "Login") as? String {
                loginBtn.setTitle(loginBtnTxt, for: .normal)
            }
            
            languageLbl.text = SelectLanguageVC.selectedLanguage
            }
        
    }
    
    
    
    //Login Function
    func loginPageFunc() {
        APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: UIActivityIndicatorView.Style.whiteLarge)
        self.view.isUserInteractionEnabled = false
        let loginParam : NSDictionary = ["UserName": "+91" + loginMobNumTF.text!,
                                         "Password": loginPasswordTF.text!]
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
                    }
                    else {
                        ForgotPasswordVC.PhNumStatus = 3
                        self.statusOfLogin = (jsonData.value(forKey: "ResultObject") as? NSDictionary)!
                        
                        let status = (self.statusOfLogin.value(forKey: "Status") as? Int)!
                        print("Printing the status: ",status)
                        let statusMsg = self.statusOfLogin.value(forKey: "Message") as? String ?? ""
                        
                        if(status != 1) {
                            APIListForXohri.showAlertMessage(vc: self, messageStr: statusMsg)
                            APIListForXohri.hideActivityIndicator()
                            self.view.isUserInteractionEnabled = true
                        }
                        else {
                            LoginVC.userInfo.setValue(self.loginMobNumTF.text!, forKey: "UserPhoneNum")
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
                                print("Printing the phonenumber of the user when user Login: ", UserDefaults.standard.string(forKey: "UserPhoneNum"))

                            }
                            
                            UserDefaults.standard.synchronize()

                            LoginVC.userInfo.setValue(self.userDetails.value(forKey: "FullName"), forKey: "UserName")
                            LoginVC.userInfo.setValue(self.userDetails.value(forKey: "PhoneNo"), forKey: "UserPhoneNum")
                            
                            
                            APIListForXohri.hideActivityIndicator()
                            self.view.isUserInteractionEnabled = true
                            self.performSegue(withIdentifier: "LoginToHome", sender: self)
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
    
    func doneButtonAction(){
        let tooBar: UIToolbar = UIToolbar()
        tooBar.barStyle = UIBarStyle.default
        tooBar.items=[
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action : #selector(self.donePressed))]
        tooBar.sizeToFit()
        loginMobNumTF.inputAccessoryView = tooBar
    }
    
    //TO RESIGN NUMERIC KEYBOARD
    @objc func donePressed () {
        loginMobNumTF.resignFirstResponder()
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
    //PASSWORD FORMATE VALIDATION.
    func validatePassword(testStr:String) -> Bool {
        if(testStr.count < 6) {
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Password Should Contain Atleast 6 Characters")
            return false
        }
        return true
    }
    
    //VALIDATING TEXTFIELD WITH 10DIGITS AND CORRECT PASSWORD.
    func validateTextFields() -> Bool {
        if (loginMobNumTF.text?.count != 10){
            //loginMobNumTF.text  = ""
            APIListForXohri.showAlertMessage(vc: self, messageStr: "You Have Entered Incorrect Number, Please Enter Valid 10 digit Mobile Number")
            return false
        }
        if validatePassword(testStr: loginPasswordTF.text!) == false{
            //loginPasswordTF.text = ""
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
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.clearsOnBeginEditing = false
//        if(textField == loginPasswordTF){
//            moveTextField(textField, moveDistance: 50, up: false)
//        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == loginMobNumTF){
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let newString: String = currentString.replacingCharacters(in: range, with: string) as String
            if(newString.count < 10) {
                loginRememberMeBtn.isSelected = false
                loginRememberMeBtn.setImage(UIImage(named: "icons8-unchecked-checkbox-filled-50"), for: .normal)
                loginPasswordTF.text = ""
            }
            if (newString.count == 10) {
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
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField == loginMobNumTF){
            if((loginMobNumTF.text?.count)! < 10){
                APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Enter Valid 10 digit Mobile Number!!")
            }
        }
        
        if(textField == loginPasswordTF){
            if((loginPasswordTF.text?.count)! < 6){
                APIListForXohri.showAlertMessage(vc: self, messageStr: "Password should contain atleast 6 characters!!")
            }
        }
//        if(textField == loginPasswordTF){
//            moveTextField(textField, moveDistance: -50, up: false)
//        }
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
    
    @IBAction func forgetPasswordAction(_ sender: UIButton) {
        performSegue(withIdentifier: "SignInToForgetPass", sender: self)
    }
    
    @IBAction func rememberMeAction(_ sender: UIButton) {
        if let currentTextField = currentTextField {
            moveTextField(loginPasswordTF, moveDistance: 100, up: false)
        }
        
        if (sender.isSelected == true){
            sender.isSelected = false;
        }
        else {
            print("Clicked true for remember me!!")
            sender.isSelected = true;
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
        loginMobNumTF.resignFirstResponder()
        loginPasswordTF.resignFirstResponder()
    }
    @IBAction func langBtnAction(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SelectLanguageVC") as! SelectLanguageVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.delegateOfLang = self
        present(vc, animated: true)
        
//        performSegue(withIdentifier: "LoginToLangSettingPage", sender: self)
        
    }
    
    @IBAction func createAccountBtnAction(_ sender: UIButton) {
        performSegue(withIdentifier: "LoginToSignUp", sender: self)
    }
    
}

