
//
//  QuotationRequestVC.swift
//  Farmer
//
//  Created by Apple on 14/06/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import Alamofire

class QuotationRequestVC: UIViewController {
    @IBOutlet weak var planningPurchaseLbl: UILabel!
    @IBOutlet weak var immediatelyBtn: UIButton!
    @IBOutlet weak var month1Btn: UIButton!
    @IBOutlet weak var months3Btn: UIButton!
    @IBOutlet weak var after3MonthsBtn: UIButton!
    @IBOutlet weak var loanLbl: UILabel!
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var noBtn: UIButton!
    @IBOutlet weak var addAddress: UIButton!
    @IBOutlet weak var termsConditionLbl: UILabel!
    @IBOutlet weak var imageOfTermsConditions: UIImageView!
    @IBOutlet weak var termsConditionsBtn: UIButton!
    @IBOutlet weak var requestBtn: UIButton!
    @IBOutlet weak var checkboxBtn: UIButton!
    
    static var addressVariable = String()
    var status = String()
    var msgReceived = String()
    var puchasePlan = String()
    var loanRequired = String()
    var conditionsChecked = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //requestQuotation()
        QuotationRequestVC.addressVariable = "RFQPage"
        addAddress.layer.borderWidth = 1
        addAddress.layer.borderColor = UIColor.black.cgColor
        addAddress.layer.cornerRadius = 4
    }
    
    func requestQuotation(){
        let param = ["UserId":UserDefaults.standard.value(forKey: "UserId"),"ModelId":SelectModelVC.modelId,"PurchaseTimeline":puchasePlan,"LookingForFinance":loanRequired,"AddressId": AddingAddressVC.addressId,"IsAgreed":conditionsChecked,"LookingForDetailsId":LookingForItemVC.detailsId]
        Alamofire.request(APIListForXohri.requestQuotation, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [:]).responseJSON{(response:DataResponse<Any>) in
            switch response.result{

            case .success(_):
                let res = response.result.value as? NSDictionary
                self.status = (res?.value(forKey: "Status") as? String)!
                APIListForXohri.showAlertMessage(vc: self, messageStr: (res?.value(forKey: "Message") as? String)!)

            case .failure(_):
                 print("requestQuotation service call failed in QuotationRequestVC:",response.result.value)
            }
        }
    }
    
    @IBAction func purchaseOptionsBtnAction(_ sender: UIButton) {
        if(sender.tag == 1){
            puchasePlan = "Immediately"
            sender.isSelected = true
            month1Btn.isSelected = false
            months3Btn.isSelected = false
            after3MonthsBtn.isSelected = false
        }
        else if(sender.tag == 2){
            puchasePlan = "1 Month"
            sender.isSelected = true
            immediatelyBtn.isSelected = false
            months3Btn.isSelected = false
            after3MonthsBtn.isSelected = false
        }
        else if(sender.tag == 3){
            puchasePlan = "3 Months"
            sender.isSelected = true
            immediatelyBtn.isSelected = false
            month1Btn.isSelected = false
            after3MonthsBtn.isSelected = false
        }
        else if(sender.tag == 4){
            puchasePlan = "After 3 Months"
            sender.isSelected = true
            immediatelyBtn.isSelected = false
            month1Btn.isSelected = false
            months3Btn.isSelected = false
        }
    }
    
    @IBAction func lookingForLoanBtnAction(_ sender: UIButton) {
        if(sender.tag == 1){
            loanRequired = "True"
            sender.isSelected = true
            noBtn.isSelected = false
        }
        else if(sender.tag == 2){
            loanRequired = "False"
            sender.isSelected = true
            yesBtn.isSelected = false
        }
    }
    
    @IBAction func checkBoxBtnAction(_ sender: UIButton) {
        if(sender.isSelected == true){
            conditionsChecked = "False"
            sender.isSelected = false
        }
        else{
            conditionsChecked = "True"
            sender.isSelected = true
        }
    }
    
    @IBAction func addAddressBtnAction(_ sender: UIButton) {
       performSegue(withIdentifier: "RFQtoAddressDetailsPage", sender: self)
    }
}
