//
//  OTPpageVC.swift
//  Xohri
//
//  Created by Apple on 09/01/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import Alamofire
import ACFloatingTextfield

class OTPpageVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var completeView: UIView!
    @IBOutlet weak var otpTxtFld: ACFloatingTextField!
    @IBOutlet weak var txtBelowOptLbl: UILabel!
    @IBOutlet weak var confirmOTP: UIButton!
    @IBOutlet weak var close: UIButton!
    @IBOutlet weak var otpLbl: UILabel!
    @IBOutlet weak var resendOTPBtn: UIButton!
    
    var otp = Int()
    var dataDict = NSDictionary()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        //let recovedUserJsonData = UserDefaults.standard.object(forKey: "DataInDiffLang")
        //dataDict = NSKeyedUnarchiver.unarchiveObject(with: recovedUserJsonData as! Data) as! NSDictionary
        otpTxtFld.delegate = self
        
        otpTxtFld.layer.cornerRadius = 4
        otpTxtFld.lineColor = UIColor.darkGray
        otpTxtFld.selectedLineColor = UIColor.darkGray
        otpTxtFld.placeHolderColor = UIColor.lightGray
        otpTxtFld.selectedPlaceHolderColor = UIColor.lightGray
        otpTxtFld.backgroundColor = UIColor.darkGray
        
        if(ForgotPasswordVC.PhNumStatus == 1){
            txtBelowOptLbl.text = "Please enter the OTP below to reset password."
        }
        else if (ForgotPasswordVC.PhNumStatus == 2) {
            txtBelowOptLbl.text = "Please enter the OTP below for registration."
        }
        
        confirmOTP.layer.cornerRadius = 5
        confirmOTP.backgroundColor = UIColor.red
        
        doneButtonAction()
        
        if let otpLblText = dataDict.value(forKey: "OTP") as? String {
            otpLbl.text = otpLblText
        }
        //        if let confirmOtpBtnTxt = dataDict.value(forKey: "Submit") as? String {
        //            confirmOTP.setTitle(confirmOtpBtnTxt, for: .normal)
        //        }
    }
    
    //DONE BUTTON IN NUMERIC KEYPAD
    func doneButtonAction(){
        let tooBar: UIToolbar = UIToolbar()
        tooBar.barStyle = UIBarStyle.default
        tooBar.items=[
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action : #selector(self.donePressed))]
        tooBar.sizeToFit()
        otpTxtFld.inputAccessoryView = tooBar
    }
    
    //TO RESIGN NUMERIC KEYBOARD
    @objc func donePressed () {
        otpTxtFld.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("Textfield value",textField.text, " string:",string)
        let tfValue = textField.text! + string
        let receivedOtp = LoginVC.userInfo.value(forKey: "otp") as! String
        if(tfValue.count == receivedOtp.count){
            if(LoginVC.userInfo.value(forKey: "otp") as! String != tfValue){
                if(string != ""){
                    APIListForXohri.showToast(view: self.view, message: "Please enter OTP received!")
                }
            }
        }
        if(tfValue.count > 6){
            return false
        }
        return true
    }
    
    func verifyOTP() {
        APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: .gray)
        self.view.isUserInteractionEnabled = false
        let data = ["PhoneNo": "\(LoginVC.userInfo.value(forKey: "UserPhoneNum") as! String)"]
        let param = ["objUser": data]
        Alamofire.request(APIListForXohri.verifyRegOTP, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [:]).responseJSON
            {   (response:DataResponse<Any>) in
                switch response.result{
                case .success(_):
                    print("Print service response.result.value in OTPVC:",response.result.value)
                    let res = response.result.value as? NSDictionary
                    if let msg = res?.value(forKey: "Message"){
                        APIListForXohri.hideActivityIndicator()
                        self.view.isUserInteractionEnabled = true
                        print("Something wrong in OTP verification service call in OTPPage",msg)
                    }
                    else{
                        print("Print service response in OTPVC:",res)
                        let response = res?.value(forKey: "Response") as? NSDictionary
                        if(response!["Message"] is NSNull){
                            print("Something wrong in verifyOTP service call in OTPVC")
                        }
                        else {
                            //let res = response?.value(forKey: "ResultObject") as? NSDictionary
                            let userData = res!.value(forKey: "user") as? NSDictionary
                            LoginVC.userInfo.setValue(userData?.value(forKey: "FullName") as? String, forKey: "UserName")
                            LoginVC.userInfo.setValue(userData?.value(forKey: "PhoneNo")  as? String, forKey: "UserPhoneNum")
                            let alert = UIAlertController(title: "Message", message: (response?.value(forKey: "Message") as? String)!, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action:UIAlertAction!) in
                                let userDetails = res?.value(forKey: "user") as? NSDictionary
                                LoginVC.userInfo.setValue(userDetails?.value(forKey: "Id"), forKey: "userId")
                                UserDefaults.standard.set(userDetails?.value(forKey: "Id"), forKey: "UserId")
                                APIListForXohri.hideActivityIndicator()
                                self.view.isUserInteractionEnabled = true
                                self.performSegue(withIdentifier: "otpToHomeOfXohri", sender: self)
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                case .failure(_):
                    APIListForXohri.hideActivityIndicator()
                    self.view.isUserInteractionEnabled = true
                    print("Service call failed in OTP verication page")
                }
        }
    }
    
    func resendOtpFuncCall(){
        APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: UIActivityIndicatorView.Style.gray)
        self.view.isUserInteractionEnabled = false
        let Param = ["UserName" : "\(LoginVC.userInfo.value(forKey: "UserPhoneNum") as! String)"]
        Alamofire.request(APIListForXohri.resendOTP, method: .post, parameters: Param, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success:
                if let data = response.result.value {
                    let jsonData = data as! NSDictionary
                    let status = jsonData.value(forKey: "Status") as? Int
                    if status == 0 {
                        APIListForXohri.hideActivityIndicator()
                        self.view.isUserInteractionEnabled = true
                        APIListForXohri.showAlertMessage(vc: self, messageStr: "Mobile Number Not Registered!")
                    }
                    else if status != 2 {
                        let message: String = jsonData.value(forKey: "Message") as? String ?? ""
                        if(message == "An error has occurred.") {
                            if let messageOfOtpStatus = jsonData.value(forKey: "Message") as? String {
                                APIListForXohri.showAlertMessage(vc: self, messageStr: messageOfOtpStatus)
                            }
                            self.view.isUserInteractionEnabled = true
                            APIListForXohri.hideActivityIndicator()
                            print("Something Went Wrong!!",message)
                        }
                        else {
                            self.otp = Int((jsonData.value(forKey: "OTP") as? String)!)!
                            print("Printing the OTP generated: ", self.otp)
                            let alert = UIAlertController(title: "Message", message: jsonData.value(forKey: "Message") as? String, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action:UIAlertAction!) in
                                APIListForXohri.hideActivityIndicator()
                                self.view.isUserInteractionEnabled = true
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                    else {
                        let message: String = jsonData.value(forKey: "Message") as? String ?? ""
                        self.view.isUserInteractionEnabled = true
                        APIListForXohri.hideActivityIndicator()
                        APIListForXohri.showAlertMessage(vc: self, messageStr: message)
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
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if((textField.text?.count)! != 6){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please enter valid OTP!")
        }
    }
    
    @IBAction func ConfirmBtnAction(_ sender: UIButton) {
        if(otpTxtFld.text?.count != 6) {
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please enter valid OTP!")
        }
        else if(otpTxtFld.text != LoginVC.userInfo.value(forKey: "otp") as? String) {
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please enter OTP received!")
        }
        else {
            if(APIListForXohri.isInternetAvailable() ==  false){
                APIListForXohri.showAlertMessage(vc: self, messageStr: "Please check your Internet Connection!!!")
            }
            else {
                if(ForgotPasswordVC.PhNumStatus == 1){
                    if(otpTxtFld.text == LoginVC.userInfo.value(forKey: "otp") as? String) {
                        performSegue(withIdentifier: "otpToReset", sender: self)
                    }
                }
                else if (ForgotPasswordVC.PhNumStatus == 2) {
                    verifyOTP()
                }
            }
        }
    }
    
    @IBAction func resendBtnAction(_sender: UIButton) {
        if(APIListForXohri.isInternetAvailable() ==  false){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please check your Internet Connection!!!")
            
        } else {
            resendOtpFuncCall()
        }
    }
    @IBAction func closeBtnAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        otpTxtFld.resignFirstResponder()
    }
}
