//
//  ForgotPasswordVC.swift
//  Xohri
//
//  Created by Apple on 10/01/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import Alamofire
import ACFloatingTextfield

class ForgotPasswordVC: UIViewController,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var regNumTebleView: UITableView!
    @IBOutlet weak var close: UIButton!
    @IBOutlet weak var regNumTxtFld: ACFloatingTextField!
    @IBOutlet weak var mobileNumberTextField: ACFloatingTextField!
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var forgorPassLbl: UILabel!
    @IBOutlet weak var txtBelowFPLbl: UILabel!
    @IBOutlet weak var regNumView: UIView!
    
    var otp = Int()
    var dataDict = NSDictionary()
    static var PhNumStatus = Int()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regNumTxtFld.text = "+91"
        regNumView.isHidden = true
        regNumView.layer.borderColor = UIColor.lightGray.cgColor
        regNumView.layer.borderWidth = 1
        regNumView.layer.cornerRadius = 2
        
        mobileNumberTextField.layer.cornerRadius = 4
        mobileNumberTextField.lineColor = UIColor.darkGray
        mobileNumberTextField.selectedLineColor = UIColor.darkGray
        mobileNumberTextField.placeHolderColor = UIColor.lightGray
        mobileNumberTextField.selectedPlaceHolderColor = UIColor.lightGray
        mobileNumberTextField.backgroundColor = UIColor.darkGray
        
        regNumTxtFld.layer.cornerRadius = 4
        regNumTxtFld.lineColor = UIColor.darkGray
        regNumTxtFld.selectedLineColor = UIColor.darkGray
        regNumTxtFld.placeHolderColor = UIColor.lightGray
        regNumTxtFld.selectedPlaceHolderColor = UIColor.lightGray
        regNumTxtFld.backgroundColor = UIColor.darkGray
        
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(labelTap))
        regNumTxtFld.text = "+91"
        regNumTxtFld.isUserInteractionEnabled = false
//        regNumTxtFld.addGestureRecognizer(tap)
        
        mobileNumberTextField.delegate = self
        
        submit.backgroundColor = UIColor.red
        submit.layer.cornerRadius = 5
        
        if let forgetPassLbl = dataDict.value(forKey: "ForgotPassword") as? String {
            forgorPassLbl.text = forgetPassLbl + "?"
        }
        if let txtbelowFP = dataDict.value(forKey: "ForgotPasswordText") as? String {
            txtBelowFPLbl.text = txtbelowFP
        }
        if let mobileNumPlaceHolder = dataDict.value(forKey: "EnterPhoneNo") as? String {
            mobileNumberTextField.placeholder = mobileNumPlaceHolder
        }
        if let submitBtnTxt = dataDict.value(forKey: "Submit") as? String {
            submit.setTitle(submitBtnTxt, for: .normal)
        }
        doneButtonAction()
    }
    
    @objc func labelTap(sender: UITapGestureRecognizer){
        if(regNumView.isHidden == true){
            regNumView.isHidden = false
        }
        else{
            regNumView.isHidden = true
        }
    }
    
    //DONE BUTTON IN NUMERIC KEYPAD
    func doneButtonAction(){
        let tooBar: UIToolbar = UIToolbar()
        tooBar.barStyle = UIBarStyle.default
        tooBar.items=[
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action : #selector(self.donePressed))]
        tooBar.sizeToFit()
        mobileNumberTextField.inputAccessoryView = tooBar
    }
    
    //TO RESIGN NUMERIC KEYBOARD
    @objc func donePressed () {
        mobileNumberTextField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == mobileNumberTextField){
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let newString: String = currentString.replacingCharacters(in: range, with: string) as String
            return newString.count <= maxLength
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forgetPassCell") as! ForgotPasswordTableViewCell
        cell.regNumTF.text = "+91"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        regNumView.isHidden = true
    }
    
    func forgotPasswordFunc() {
        APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: UIActivityIndicatorView.Style.gray)
        self.view.isUserInteractionEnabled = false
        let Param = ["UserName" : regNumTxtFld.text! + mobileNumberTextField.text!]
        Alamofire.request(APIListForXohri.forgetPassword, method: .post, parameters: Param, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success:
                if let data = response.result.value {
                    let jsonData = data as! NSDictionary
                    let status = jsonData.value(forKey: "Status") as? Int
                    print("Printing the status value: ",status)
                    if status == 0 {
                        APIListForXohri.hideActivityIndicator()
                        self.view.isUserInteractionEnabled = true
                        APIListForXohri.showAlertMessage(vc: self, messageStr: "Mobile Number Not Registered!")
                    }
                    else if status != 2{
                        let message: String = jsonData.value(forKey: "Message") as? String ?? ""
                        if(message == "An error has occurred."){
                            if let messageOfOtpStatus = jsonData.value(forKey: "Message") as? String {
                                APIListForXohri.showAlertMessage(vc: self, messageStr: messageOfOtpStatus)
                            }
                            self.view.isUserInteractionEnabled = true
                            APIListForXohri.hideActivityIndicator()
                            print("Something Went Wrong!!",message)
                        }
                        else {
                            ForgotPasswordVC.PhNumStatus = 1
                            self.otp = Int((jsonData.value(forKey: "OTP") as? String)!)!
                            print("Printing the OTP generated: ", self.otp)
                            LoginVC.userInfo.setValue( self.regNumTxtFld.text! + self.mobileNumberTextField.text!, forKey: "UserPhoneNum")
                            LoginVC.userInfo.setValue(String(self.otp), forKey: "otp")
                            let alert = UIAlertController(title: "Message", message: jsonData.value(forKey: "Message") as? String, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action:UIAlertAction!) in
                                APIListForXohri.hideActivityIndicator()
                                self.view.isUserInteractionEnabled = true
                                self.performSegue(withIdentifier: "forgetToOtp", sender: self)
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
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        mobileNumberTextField.resignFirstResponder()
        regNumView.isHidden = true
    }
    
    @IBAction func closeBtnAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitBtnAction(_ sender: UIButton) {
        if ( mobileNumberTextField.text == "" || mobileNumberTextField.text == nil  ) {
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Enter Valid 10 digit Mobile Number")
            return
        }
        else if(mobileNumberTextField.text?.count != 10){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Enter Valid 10 digit Mobile Number")
            return
        }
        else {
            if(APIListForXohri.isInternetAvailable() == false){
                APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Check Your Internet Connection!!!")
            }
            else {
                forgotPasswordFunc()
            }
        }
    }
}
