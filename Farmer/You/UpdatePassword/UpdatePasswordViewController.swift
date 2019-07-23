//
//  ChangePasswordViewController.swift
//  Farmer
//
//  Created by Apple on 06/06/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import Alamofire

class UpdatePasswordViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var borderView: UIView!
    
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        oldPasswordTextField.delegate = self
        newPasswordTextField.delegate = self
        
        borderView.layer.borderWidth = 1
        borderView.layer.cornerRadius = 5
        borderView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == oldPasswordTextField){
            let fullText = textField.text! + string
            if(fullText.count > 12){
                APIListForXohri.showAlertMessage(vc: self, messageStr: "Password can not contain more than 12 characters!!")
            }
            if(string == " "){
                return false
            }
        }
        if(textField == newPasswordTextField){
            let fullText = textField.text! + string
            if(fullText.count > 12){
                APIListForXohri.showAlertMessage(vc: self, messageStr: "Password can not contain more than 12 characters!!")
            }
            if(string == " "){
                return false
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField == oldPasswordTextField) {
            if (textField.text?.count)! < 6{
                APIListForXohri.showAlertMessage(vc: self, messageStr: "Password should contain at least 6 characters!!")
            }
        }
        if(textField == newPasswordTextField) {
            if (textField.text?.count)! < 6{
                APIListForXohri.showAlertMessage(vc: self, messageStr: "Password should contain at least 6 characters!!")
            }
        }
    }
    
    func updatePassword(){
        let data = [ "Id":UserDefaults.standard.integer(forKey:"UserId") ,
                     "OldPassword":oldPasswordTextField.text!,
                     "Password": newPasswordTextField.text!] as [String : Any]
        let param = ["objUser":data]
        Alamofire.request(APIListForXohri.updatePassword, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [:]).responseJSON {(response : DataResponse<Any>) in
            switch response.result{
                
            case .success(_):
                print("Printing service response of updatePassword service call in UpdatePasswordViewController:",response.result.value)
                
            case .failure(_):
                print("UpdatePassword service call failed in UpdatePasswordViewController:",response.result.value)
            }
        }
    }
    
    @IBAction func confirmBtnAction(_ sender: UIButton) {
        if((oldPasswordTextField.text?.count)!) < 6{
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Password should contain at least 6 characters!!")
        }
        if (newPasswordTextField.text?.count)! < 6{
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Password should contain at least 6 characters!!")
        }
        if(oldPasswordTextField.text != newPasswordTextField.text){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Both Passwords should match!!")
        }
        if(APIListForXohri.isInternetAvailable() == false) {
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Check Your Internet Connection!!!")
        }
        else{
            updatePassword()
        }
    }
}
