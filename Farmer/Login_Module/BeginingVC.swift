//
//  BeginingVC.swift
//  Farmer
//
//  Created by Apple on 11/06/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit

class BeginingVC: UIViewController {

    @IBOutlet weak var xohriLbl: UILabel!
    @IBOutlet weak var signInLbl: UILabel!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidAppear(_ animated: Bool) {
        
        let username = UserDefaults.standard.string(forKey: "UserName")
        let nameOfUser = UserDefaults.standard.string(forKey: "UserName1st")
        
//        if(username != nil || nameOfUser != nil) {
//            if(username != nil) {
//                ForgotPasswordVC.PhNumStatus = 3
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomePage") as! HomeNavigationControllerVC
//                self.present(vc, animated : true)
//            }
//            else if(nameOfUser != nil){
//                ForgotPasswordVC.PhNumStatus = 2
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomePage") as! BeginingVC //HomeNavigationControllerVC
//                self.present(vc, animated : true)
//            }
//            else {
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "redirectToLoginOrSignUp") as! BeginingVC //BothLoginRegistrationVC
//                self.present(vc, animated : true)
//            }
//        }
//        else {
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "redirectToLoginOrSignUp") as! BothLoginRegistrationVC
//            self.present(vc, animated : true)
//        }
        
    }
    @IBAction func signInBtnAction(_ sender: UIButton) {
        performSegue(withIdentifier: "BeginToLogin", sender: self)
    }
    @IBAction func registerBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "BeginToRegister", sender: self)
    }
    @IBAction func changeLannguageBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "BeginToChangeLanguage", sender: self)
    }
    
}
