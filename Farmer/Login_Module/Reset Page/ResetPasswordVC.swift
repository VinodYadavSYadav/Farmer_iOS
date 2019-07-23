//
//  ResetPasswordVC.swift
//  Xohri
//
//  Created by Apple on 10/01/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import Alamofire
import SQLite3
import ACFloatingTextfield

class ResetPasswordVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var resetPassLbl: UILabel!
    @IBOutlet weak var textBelowRPLbl: UILabel!
    @IBOutlet weak var newPassword: ACFloatingTextField!
    @IBOutlet weak var reEnterPassword: ACFloatingTextField!
    @IBOutlet weak var eye1: UIButton!
    @IBOutlet weak var eye2: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var submit: UIButton!
    
    var eyeBtnArray = ["Eye_grey","EyeWithCross_Grey.png"]
    var index = 0
    var resetPassStatusDict = NSDictionary()
    var dataDict = NSDictionary()
    var statement: OpaquePointer?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//      let recovedUserJsonData = UserDefaults.standard.object(forKey: "DataInDiffLang")
//      dataDict = NSKeyedUnarchiver.unarchiveObject(with: recovedUserJsonData as! Data) as! NSDictionary
        
        newPassword.delegate = self
        reEnterPassword.delegate = self
        newPassword.isSecureTextEntry = true
        reEnterPassword.isSecureTextEntry = true
        
        submit.backgroundColor = UIColor.red
        submit.layer.cornerRadius = 5
        
        newPassword.layer.cornerRadius = 4
        newPassword.lineColor = UIColor.darkGray
        newPassword.selectedLineColor = UIColor.darkGray
        newPassword.placeHolderColor = UIColor.lightGray
        newPassword.selectedPlaceHolderColor = UIColor.lightGray
        newPassword.backgroundColor = UIColor.darkGray
        
        reEnterPassword.layer.cornerRadius = 4
        reEnterPassword.lineColor = UIColor.darkGray
        reEnterPassword.selectedLineColor = UIColor.darkGray
        reEnterPassword.placeHolderColor = UIColor.lightGray
        reEnterPassword.selectedPlaceHolderColor = UIColor.lightGray
        reEnterPassword.backgroundColor = UIColor.darkGray
        
        if let resetPassLblTxt = dataDict.value(forKey: "ResetPassword") as? String {
            resetPassLbl.text = resetPassLblTxt
        }
        if let txtBelowRP = dataDict.value(forKey: "ToContinue") as? String {
            textBelowRPLbl.text = txtBelowRP
        }
        if let newPassPlaceHolder = dataDict.value(forKey: "NewPassword") as? String {
            newPassword.placeholder = newPassPlaceHolder
        }
        if let confirmPassPlaceHolder = dataDict.value(forKey: "ReEnterPassword") as? String {
            reEnterPassword.placeholder = confirmPassPlaceHolder
        }
        if let submitBtnTxt = dataDict.value(forKey: "Submit") as? String {
            submit.setTitle(submitBtnTxt, for: .normal)
        }
        
    }
    func changePasswordFunc(){
        
        APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: UIActivityIndicatorView.Style.gray)
        self.view.isUserInteractionEnabled = false
        let resetPass : NSDictionary = [
            "UserName" :"\(LoginVC.userInfo.value(forKey: "UserPhoneNum") as! String)",
            "Password" :newPassword.text!]
        let Param = ["UserRequest" : resetPass]
        print("Printing parameters in ResetPasswordVC:",Param)
        Alamofire.request(APIListForXohri.changePassord, method: .post, parameters: Param, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
                
            case .success:
                if let data = response.result.value {
                    let jsonData = data as! NSDictionary
                    
                    if let message: String = jsonData.value(forKey: "Message") as? String{
                        self.view.isUserInteractionEnabled = true
                        APIListForXohri.hideActivityIndicator()
                        print("Something Went Wrong!!",message)
                    }
                    else {
                        self.resetPassStatusDict = jsonData.value(forKey: "ResultObject") as! NSDictionary
                        if let messageOfOtpStatus = self.resetPassStatusDict.value(forKey: "Message") as? String {
                            APIListForXohri.showToast(view: self.view, message: messageOfOtpStatus)
                        }
                        var numberEnteredByUser = BothLoginRegistrationVC.phoneNumber
                        self.newPassword.text = self.newPassword.text!
                        let query = "update users_details set password='\(self.newPassword.text)' where phonenumber ='\(BothLoginRegistrationVC.phoneNumber)'"
                            print("Print query:",query)
                                if sqlite3_prepare_v2(AppDelegate.db, query, -1, &self.statement, nil) != SQLITE_OK {
                                let errmsg = String(cString: sqlite3_errmsg(AppDelegate.db)!)
                                print("error preparing insert: \(errmsg)")
                            }
                            else{
                                print("Data updated")
                            }
                            if sqlite3_step(self.statement) != SQLITE_DONE {
                                let errmsg = String(cString: sqlite3_errmsg(AppDelegate.db)!)
                                print("failure inserting foo: \(errmsg)")
                            }
                        APIListForXohri.hideActivityIndicator()
                        self.view.isUserInteractionEnabled = true
                        self.performSegue(withIdentifier: "resetTosignUp", sender: self)
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
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == " ") {
            return false
        }
        if(textField == newPassword){
            let currentString: NSString = textField.text! as NSString
            var newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            if(newString.length > 12){
                newString = newString.replacingCharacters(in: range, with: string) as NSString
                return newString.length <= 12
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField == newPassword){
            if((newPassword.text?.count)! < 6){
                APIListForXohri.showAlertMessage(vc: self, messageStr: "Password Should Contain Atleast 6 Characters")
            }
//            if((newPassword.text?.contains(" "))!){
//                APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Don't Use Space In Your Password!")
//            }
        }
        if(textField == reEnterPassword){
            if((reEnterPassword.text?.count)! < 6){
                APIListForXohri.showAlertMessage(vc: self, messageStr: "Password Should Contain Atleast 6 Characters")
            }
        }
    }
    
    //RETURNING KEYBOARD.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        newPassword.resignFirstResponder()
        reEnterPassword.resignFirstResponder()
    }
    
    @IBAction func submitBtnAction(_ sender: UIButton) {
        if(newPassword.text == reEnterPassword.text){
            if (newPassword.text == "" || reEnterPassword.text == nil  ){
                APIListForXohri.showAlertMessage(vc: self, messageStr: "Fields Are Required To Fill In")
                return
                
            } else {
                if(APIListForXohri.isInternetAvailable() == false){
                    APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Check Your Internet Connection!!!")
                }
                else {
                    changePasswordFunc()
                }
            }
        }
        else {
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Both passwords Should Match!")
        }
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func newPasswordBtnAction(_ sender: UIButton) {
        self.index = (self.index >= self.eyeBtnArray.count-1) ? 0 : index+1
        sender.setImage(UIImage(named: eyeBtnArray[index]), for: .normal)
        if(index == 0)  {
            newPassword.isSecureTextEntry = false
        }
        else {
            newPassword.isSecureTextEntry = true
        }
    }
    
    @IBAction func confirmPasswordBtnAction(_ sender: UIButton) {
        self.index = (self.index >= self.eyeBtnArray.count-1) ? 0 : index+1
        sender.setImage(UIImage(named: eyeBtnArray[index]), for: .normal)
        if(index == 0)  {
            reEnterPassword.isSecureTextEntry = false
        }
        else {
            reEnterPassword.isSecureTextEntry = true
        }
    }
    
    
    
//    @IBAction func eyeBtnAction(_ sender: UIButton) {
//        self.index = (self.index >= self.eyeBtnArray.count-1) ? 0 : self.index+1
//        sender.setImage(UIImage(named:eyeBtnArray[index]), for: .normal)
//
//        if(index == 1){
//            if sender.tag == 1{
//                if(newPassword.isSecureTextEntry){
//                    newPassword.isSecureTextEntry = false
//                }
//                else{
//                    newPassword.isSecureTextEntry = true
//                }
//            }
//            else{
//                if(reEnterPassword.isSecureTextEntry){
//                    reEnterPassword.isSecureTextEntry = false
//                }
//                else{
//                    reEnterPassword.isSecureTextEntry = true
//                }
//            }
//        }
//    }
}
