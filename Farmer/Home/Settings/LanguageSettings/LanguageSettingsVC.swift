//
//  LanguageSettingsVC.swift
//  Xohri
//
//  Created by Apple on 10/04/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import  Alamofire

class LanguageSettingsVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var languageSettingTableView: UITableView!
    var LanguagesList = NSArray()

    var LanguageszzList = ["English","हिंदी","ಕನ್ನಡ","తెలుగు","தமிழ்","മലയാളം","मराठी","ગુજરાતી","ਪੰਜਾਬੀ","বাঙালি","اردو"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Change Language"

        if(APIListForXohri.isInternetAvailable() == false) {
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Check Your Internet Connection!!!")
            
        } else {
//            languageSettings()
            
        }
    }
    
    func languageSettings() {
        APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: UIActivityIndicatorView.Style.gray)
        self.view.isUserInteractionEnabled = false
        
        Alamofire.request(APIListForXohri.getLanguages, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
                
            case .success:
                if let data = response.result.value {
                    let jsonData = data as! NSDictionary
                    self.LanguagesList = (jsonData.value(forKey: "LanguagesList") as? NSArray)!
                    self.languageSettingTableView.reloadData()
                    
                    APIListForXohri.hideActivityIndicator()
                    self.view.isUserInteractionEnabled = true
                    
                }
                break
            case .failure:
                APIListForXohri.hideActivityIndicator()
                self.view.isUserInteractionEnabled = true
                break
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LanguageszzList.count//LanguagesList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = languageSettingTableView.dequeueReusableCell(withIdentifier: "language", for: indexPath) as! LangSettingsTableViewCell
        languageSettingTableView.tableFooterView = UIView(frame: .zero)
        cell.languageName.text = LanguageszzList[indexPath.row]
//        cell.languageName.text = (self.LanguagesList[indexPath.row] as AnyObject).value(forKey: "Language") as? String ?? ""
        
        return cell
        
    }

   
}
