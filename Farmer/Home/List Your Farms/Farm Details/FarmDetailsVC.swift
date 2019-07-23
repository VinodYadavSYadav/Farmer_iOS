//
//  FarmDetailsVC.swift
//  Farmer
//
//  Created by Apple on 08/07/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import ACFloatingTextfield

class FarmDetailsVC: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    

    @IBOutlet weak var closeBtn: UIButton!
    
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var subTiltleLbl: UILabel!
    
    @IBOutlet weak var farmNameTxtFld: ACFloatingTextField!
    @IBOutlet weak var personNameTxtFld: ACFloatingTextField!
    @IBOutlet weak var mobileNumTxtFld: ACFloatingTextField!
    @IBOutlet weak var emailIdTxtFld: ACFloatingTextField!
    
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var socialMediaCV: UICollectionView!
    
    var socialMediaList:[UIImage] = [UIImage(named: "whatsapp")!,
                               UIImage(named: "facebook")!,
                               UIImage(named: "instagram")!,
                               UIImage(named: "twitter")!]
    
    var listOfSocialMedia = ["Whatsapp", "Facebook", "Instagram", "Twitter"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueBtn.backgroundColor = UIColor(red:0.97, green:0.17, blue:0.11, alpha:1.0)
        continueBtn.layer.cornerRadius = 4
        
        farmNameTxtFld.delegate = self
        personNameTxtFld.delegate = self
        personNameTxtFld.delegate = self
        emailIdTxtFld.delegate = self
        
        farmNameTxtFld.lineColor = UIColor.darkGray
        farmNameTxtFld.selectedLineColor = UIColor(red:0.97, green:0.17, blue:0.11, alpha:1.0)
        farmNameTxtFld.placeHolderColor = UIColor.lightGray
        farmNameTxtFld.selectedPlaceHolderColor = UIColor.white
        
        personNameTxtFld.lineColor = UIColor.darkGray
        personNameTxtFld.selectedLineColor = UIColor(red:0.97, green:0.17, blue:0.11, alpha:1.0)
        personNameTxtFld.placeHolderColor = UIColor.lightGray
        personNameTxtFld.selectedPlaceHolderColor = UIColor.white
        
        mobileNumTxtFld.lineColor = UIColor.darkGray
        mobileNumTxtFld.selectedLineColor = UIColor(red:0.97, green:0.17, blue:0.11, alpha:1.0)
        mobileNumTxtFld.placeHolderColor = UIColor.lightGray
        mobileNumTxtFld.selectedPlaceHolderColor = UIColor.white
        
        emailIdTxtFld.lineColor = UIColor.darkGray
        emailIdTxtFld.selectedLineColor = UIColor(red:0.97, green:0.17, blue:0.11, alpha:1.0)
        emailIdTxtFld.placeHolderColor = UIColor.lightGray
        emailIdTxtFld.selectedPlaceHolderColor = UIColor.white

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfSocialMedia.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = socialMediaCV.dequeueReusableCell(withReuseIdentifier: "socialMedia", for: indexPath) as! SocialMediaCollectionViewCell
        cell.sociaMediaName.text = listOfSocialMedia[indexPath.item]
        cell.sociaMediaImage.image = socialMediaList[indexPath.item]
        
        //

        return cell
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
    
    @IBAction func continueBtnAction(_ sender: UIButton) {
        if ( farmNameTxtFld.text == "" || personNameTxtFld.text == nil || mobileNumTxtFld.text == nil || emailIdTxtFld.text == nil ){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "All Fields Are Required To Fill In")
            return
        } else {
            performSegue(withIdentifier: "FarmLocationToImageUpload", sender: self)
        }
    }
    
    @IBAction func closeBtnAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)

//        self.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
   
}
