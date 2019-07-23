//
//  LogOutVC.swift
//  Xohri
//
//  Created by Apple on 19/02/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import SQLite3

class LogOutVC: UIViewController {
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var txtLbl: UILabel!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var statement :OpaquePointer?
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        popUpView.layer.shadowColor = UIColor.black.cgColor
        popUpView.layer.shadowOffset = CGSize(width: 0, height: 10)
        popUpView.layer.shadowOpacity = 0.9
        popUpView.layer.shadowRadius = 5
        popUpView.clipsToBounds = true
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.showAnimate()
        
        UserDefaults.standard.removeObject(forKey: "UserId")
        UserDefaults.standard.removeObject(forKey: "UserName")
        UserDefaults.standard.removeObject(forKey: "UserName1st")
        UserDefaults.standard.removeObject(forKey: "UserPhoneNum")
        UserDefaults.standard.removeObject(forKey: "UserPhoneNumber1st")
        UserDefaults.standard.removeObject(forKey: "UserEmailID1st")
        
        
        UserDefaults.standard.removeObject(forKey: "StateID")
        UserDefaults.standard.removeObject(forKey: "DistrictID")
        UserDefaults.standard.removeObject(forKey: "TalukID")
        UserDefaults.standard.removeObject(forKey: "HobliID")
        
        UserDefaults.standard.removeObject(forKey: "DataInDiffLang")
        UserDefaults.standard.removeObject(forKey: "userJson")
        UserDefaults.standard.removeObject(forKey: "userData")
        
        UserDefaults.standard.removeObject(forKey: "userJson")
        UserDefaults.standard.removeObject(forKey: "userData")
        
        let query = "update users_details set loginConditions = 0"
        
        if sqlite3_prepare_v2(AppDelegate.db, query, -1, &statement, nil) != SQLITE_OK {
            
            let errmsg = String(cString: sqlite3_errmsg(AppDelegate.db)!)
            
            print("error preparing insert: \(errmsg)")
            
        } else {
            
            print("Data updated")
            
        }
        
        if sqlite3_step(self.statement) != SQLITE_DONE {
            
            let errmsg = String(cString: sqlite3_errmsg(AppDelegate.db)!)
            print("failure inserting foo in ViewPagerVC: \(errmsg)")
            
        }

    }
    
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    
    @IBAction func confirmBtnAction(_ sender: UIButton) {
        performSegue(withIdentifier: "logoutToSelectLanguage", sender: self)
    }

    @IBAction func cancelBtnAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
