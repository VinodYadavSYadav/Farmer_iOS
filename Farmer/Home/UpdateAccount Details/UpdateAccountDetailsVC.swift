//
//  UpdateAccountDetailsVC.swift
//  Farmer
//
//  Created by Apple on 18/06/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import Alamofire

class UpdateAccountDetailsVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var imageOfUser: UIImageView!
    @IBOutlet weak var updateAccDetailsLbl: UILabel!
    @IBOutlet weak var nameTxtFld: UITextField!
    @IBOutlet weak var mobileNumberTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var nameStatusImage: UIImageView!
    @IBOutlet weak var mobileNumStatusImage: UIImageView!
    @IBOutlet weak var passwordImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTxtFld.delegate = self
        mobileNumberTxtFld.delegate = self
        passwordTxtFld.delegate = self
        
        updateBtn.backgroundColor = UIColor(red:0.97, green:0.17, blue:0.11, alpha:1.0)
        updateBtn.layer.cornerRadius = 5
        
        mobileNumberTxtFld.isUserInteractionEnabled = true
        passwordImageView.isHidden = true
        nameTxtFld.text = "Monisha"
        mobileNumberTxtFld.text = "7406491929"
        
//        getUserDetails()
    }
   
    func getUserDetails(){
        APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: UIActivityIndicatorView.Style.gray)
        self.view.isUserInteractionEnabled = false
        let data = ["Id":UserDefaults.standard.string(forKey: "UserId")]
        let param = ["objUser":data]
        print("Printing parameters of get UserDetails:",param)
        Alamofire.request(APIListForXohri.getUserDetails, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [:]).responseJSON {(response : DataResponse<Any>) in
            switch response.result{
                
            case .success(_):
                let res = response.result.value as? NSDictionary
                let userData = res?.value(forKey: "user") as? NSDictionary
                self.nameTxtFld.text = userData?.value(forKey: "FullName") as? String
                self.mobileNumberTxtFld.text = userData?.value(forKey: "PhoneNo") as? String
                
                let imgURL = URL(string: (userData?.value(forKey: "ProfilePic") as? String)!)
                if(imgURL != nil){
                    if let imgData = try? Data(contentsOf: imgURL!){
                        let img : UIImage = UIImage(data: imgData)!
                        if(img != nil){
                            self.imageOfUser.image = img
                        }
                    }
                }
                
                self.view.isUserInteractionEnabled = true
                APIListForXohri.hideActivityIndicator()
                
            case .failure(_):
                print("getUserDetails Service response in UpdateAccountsDetailsVC:",response.result.value )
                self.view.isUserInteractionEnabled = true
                APIListForXohri.hideActivityIndicator()
            }
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.clearsOnBeginEditing = false
        if(textField == passwordTxtFld){
            textField.clearsOnBeginEditing = false
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == nameTxtFld){
            print("textField.text:",textField.text)
            if(textField == nameTxtFld){
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
        
        if(textField == passwordTxtFld){
            if((textField.text?.count)! > 11){
                if(string == ""){
                    return true
                }
                else{
                    APIListForXohri.showAlertMessage(vc: self, messageStr: "Password can have maximum of 12 characters!!")
                    return false
                }
            }
        }  else {
            passwordImageView.isHidden = false
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if(textField == nameTxtFld){
            if(validateName(textField: textField.text!) == true){
                if(!(nameTxtFld.text?.isEmpty)!){
                    if((nameTxtFld.text?.count)! < 2){
                        APIListForXohri.showAlertMessage(vc: self, messageStr: "Name should contain atleast 2 characters!!")
                    }
                }
            }
            else{
                APIListForXohri.showAlertMessage(vc: self, messageStr: "Please enter valid name!!")
            }
        }
        else if(textField == passwordTxtFld){
            if((textField.text?.count)! < 6){
                APIListForXohri.showAlertMessage(vc: self, messageStr: "Password should contain atleast 6 characters!!")
            }
            else if((textField.text?.count)! > 12){
                APIListForXohri.showAlertMessage(vc: self, messageStr: "Password can contain 12 characters!!")
            }
            
        }
        
    }
    func updateUserProfile() {
//        print("UserId:",UserDefaults.standard.string(forKey: "UserId") as? String," fullName:",UserDefaults.standard.string(forKey: "UserName") as? String, " phone num:",UserDefaults.standard.string(forKey: "UserPhoneNum") as? String," email:",emailIdTxtFld.text!)
//        let data = ["UserId":UserDefaults.standard.string(forKey: "UserId") as? String,"FullName":UserDefaults.standard.string(forKey: "UserName") as? String,"PhoneNo":UserDefaults.standard.string(forKey: "UserPhoneNum") as? String,"EmailId":emailIdTxtFld.text!,"Password":passwordTxtFld.text!]
//        print("Printing parameters of updateUserDetails:",data)
        
        Alamofire.upload(multipartFormData:{ multipartFormData in
//            if(self.uploadingImage != nil){
//                multipartFormData.append(self.uploadingImage!.jpegData(compressionQuality: 0.5)!, withName: "", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
//            }
            multipartFormData.append((UserDefaults.standard.string(forKey: "UserId")?.data(using: String.Encoding.utf8)!)!, withName: "UserId")
            multipartFormData.append((UserDefaults.standard.string(forKey: "UserName")?.data(using: String.Encoding.utf8)!)!, withName: "FullName")
            multipartFormData.append((UserDefaults.standard.string(forKey: "UserPhoneNum")?.data(using: String.Encoding.utf8)!)!, withName: "PhoneNo")
            multipartFormData.append((self.passwordTxtFld.text?.data(using: String.Encoding.utf8)!)!, withName: "Password")
        },
                         usingThreshold:UInt64.init(),
                         to:APIListForXohri.updateUserProfile,
                         method:.post,
                         headers:nil,
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.responseJSON { response in
                                    debugPrint(response)
                                    print("Uploaded successfully",response)
                                    
                                    let fetcedResponse = response.result.value as! NSDictionary
                                    
                                    if let message: String = fetcedResponse.value(forKey: "Message") as? String{
                                        self.view.isUserInteractionEnabled = true
                                        APIListForXohri.hideActivityIndicator()
                                        print("Something Went Wrong!!",message)
                                    }
                                    else {
                                        let value = fetcedResponse.value(forKey: "Response") as! NSDictionary
                                        //value.value(forKey: "Message") as? String
                                        if((value.value(forKey: "status") as? Int)! > 0){
                                        let alert = UIAlertController(title: "Message", message: "User details updated successfully!!", preferredStyle: .alert)
                                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                                            self.view.isUserInteractionEnabled = true
                                            APIListForXohri.hideActivityIndicator()
                                        }))
                                        self.present(alert, animated: true, completion: nil)
                                        }
                                    }
                                }
                                
                            case .failure(let encodingError):
                                print(encodingError)
                                self.view.isUserInteractionEnabled = true
                                APIListForXohri.hideActivityIndicator()
                            }
        })
//        Alamofire.request(APIListForXohri.updateUserProfile, method: .post, parameters: data, encoding: JSONEncoding.default, headers: [:]).responseJSON {(response:DataResponse<Any>) in
//            switch response.result{
//
//            case .success(_):
//                print("Print updateUserProfile service response in UpdateAccountDetailsVC:",response.result.value)
//                self.view.isUserInteractionEnabled = true
//                APIListForXohri.hideActivityIndicator()
//
//            case .failure(_):
//                print("UpdateUserProfile service failed in UpdateAccountDetailsVC:",response.result.value)
//                self.view.isUserInteractionEnabled = true
//                APIListForXohri.hideActivityIndicator()
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
    
    //Name Validation
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
    
    //Email Validation
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    func validate() -> Bool{
        if !((nameTxtFld.text?.isEmpty)!){
            if((nameTxtFld.text?.count)! < 2){
                APIListForXohri.showAlertMessage(vc: self, messageStr: "Name should contain atleast 2 characters!!")
                return false
            }
        } else if (validateName(textField: nameTxtFld.text!) ==  false){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Enter Valid Name")
            return false
        }
        
        if((passwordTxtFld.text?.count)! < 6){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Password Should Contain Atleast 6 Characters!!")
            return false
        }
        else if((passwordTxtFld.text?.count)! > 12){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Password Can Have Maximum Of 12 Characters!!")
            return false
        }

        return true
    }
    
    @IBAction func updateBtnAction(_ sender: UIButton) {
        if(validate() == true){
//            updateUserProfile()
        }
    }
    
    @IBAction func closeBtnAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        nameTxtFld.resignFirstResponder()
        mobileNumberTxtFld.resignFirstResponder()
        passwordTxtFld.resignFirstResponder()
    }
}
