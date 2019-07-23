//
//  FeedBackVC.swift
//  Farmer
//
//  Created by Apple on 18/06/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import Alamofire

class FeedBackVC: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var suggAndFeedbackBtn: UIButton!
    @IBOutlet weak var technicalProbBtn: UIButton!
    @IBOutlet weak var othersBtn: UIButton!
    
    @IBOutlet weak var feedBackTitleTF: UITextField!
    @IBOutlet weak var feedbackDescTV: UITextView!
    
    @IBOutlet weak var submitBtn: UIButton!
    var feedbackType : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Feedback"
        
        feedbackDescTV.delegate = self
        feedBackTitleTF.delegate = self
        
        feedbackDescTV.text = "Feedback Describe"
        feedbackDescTV.textColor = UIColor(red:0.78, green:0.78, blue:0.80, alpha:1.0)
        
        feedbackDescTV.delegate = self
        feedbackDescTV.layer.cornerRadius = 4
        feedbackDescTV.layer.borderWidth = 0.8
        feedbackDescTV.layer.borderColor = UIColor(red:0.78, green:0.78, blue:0.80, alpha:1.0).cgColor
        
        submitBtn.backgroundColor = UIColor(red:0.97, green:0.17, blue:0.11, alpha:1.0)
        submitBtn.layer.cornerRadius = 5
        
    }
    
    func feedbackService() {
        APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: UIActivityIndicatorView.Style.gray)
        self.view.isUserInteractionEnabled = false
        let param:[String : Any] = [
            "FeedbackType": feedbackType,
            "FeedbackTitle": feedBackTitleTF.text!,
            "FeedbackDescription": feedbackDescTV.text!,
            "CreatedBy":UserDefaults.standard.integer(forKey: "UserId")
        ]
        
        Alamofire.request(APIListForXohri.feedbackPosting, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
                
            case .success:
                if let data = response.result.value {
                    let jsonData = data as! NSDictionary
                    print("FeedBack", jsonData)
                    let status = Int(jsonData.value(forKey: "Status") as! String)
                    if(status! > 0) {
                        APIListForXohri.showAlertMessage(vc: self, messageStr: jsonData.value(forKey: "Message") as! String)
                        //                        APIListForXohri.showToast(view: self.view, message: jsonData.value(forKey: "Message") as! String)
                    }
                    self.feedBackTitleTF.text = ""
                    self.feedbackDescTV.text = ""
//                    self.navigationController?.popViewController(animated: true)

                    
                    APIListForXohri.hideActivityIndicator()
                    self.view.isUserInteractionEnabled = true
                }
                
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
        return true

    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if(text == "\n") {
            feedbackDescTV.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if feedbackDescTV.textColor == UIColor(red:0.78, green:0.78, blue:0.80, alpha:1.0)
        {
            feedbackDescTV.text = ""
            feedbackDescTV.textColor = UIColor(red:0.12, green:0.14, blue:0.21, alpha:1.0)
        }
    }
    
    //returns placeholders when user write nothing
    func textViewDidEndEditing(_ textView: UITextView) {
        if feedbackDescTV.text.isEmpty {
            feedbackDescTV.text = "Feedback Describe"
            feedbackDescTV.textColor = UIColor(red:0.78, green:0.78, blue:0.80, alpha:1.0)
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
    
    @IBAction func submitBtnAction(_ sender: UIButton) {
        if(APIListForXohri.isInternetAvailable() == false){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Check Your Internet Connection!!!")
        }
        else {
                feedbackService()
        }
    }
    @IBAction func feedbackTypeBtnAction(_ sender: UIButton) {
        if(sender.tag == 1){
            feedbackType = "AppSuggestionsAndFeedback"
            suggAndFeedbackBtn.isSelected = true
            technicalProbBtn.isSelected = false
            othersBtn.isSelected = false
            
        }
        else if(sender.tag == 2){
            feedbackType = "AppTechnicalProblem"
            suggAndFeedbackBtn.isSelected = false
            technicalProbBtn.isSelected = true
            othersBtn.isSelected = false
            
        }
        else if(sender.tag == 3){
            feedbackType = "Others"
            suggAndFeedbackBtn.isSelected = false
            technicalProbBtn.isSelected = false
            othersBtn.isSelected = true
            
        }
        
    }
    
}
