//
//  SettingsVC.swift
//  Farmer
//
//  Created by Apple on 17/06/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var settingListTableView: UITableView!
    
    var settingsMenu = ["Account Info", "Your Address", "Change Language", "Notification", "Refer n Earn", "Feedback", "Help & Support", "About FarmPe", "Policies", "LogOut"]
    
    var settingmenuImages : [UIImage] = [UIImage(named: "user-white")!,
                                         UIImage(named: "home")!,
                                         UIImage(named: "lang")!,
                                         UIImage(named: "notification")!,
                                         UIImage(named: "earn")!,
                                         UIImage(named: "feedback")!,
                                         UIImage(named: "help")!,
                                         UIImage(named: "info")!,
                                         UIImage(named: "policies")!,
                                         UIImage(named: "logout")!]
    
    static var webViewData = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Settings"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsMenu.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let backItem = UIBarButtonItem()
        backItem.title = " "
        navigationItem.backBarButtonItem = backItem
        if(settingsMenu[indexPath.row] == "Account Info"){
            performSegue(withIdentifier: "settingsToMyAcc", sender: self)
        }
        if(settingsMenu[indexPath.row] == "Notification"){
            performSegue(withIdentifier: "settingToNotification", sender: self)
        }
        else if(settingsMenu[indexPath.row] == "Change Language"){
            performSegue(withIdentifier: "settingToLanguagePage", sender: self)
        }
        else if(settingsMenu[indexPath.row] == "Feedback") {
            performSegue(withIdentifier: "FeedBackPage", sender: self)
        }
        else if(settingsMenu[indexPath.row] == "Refer n Earn") {
            performSegue(withIdentifier: "SettingToReferNEarn", sender: self)
        }
        else if(settingsMenu[indexPath.row] == "Help & Support") {
            SettingsVC.webViewData = "HelpAndSupport"
            performSegue(withIdentifier: "SettingToHSPA", sender: self)
        }
        else if(settingsMenu[indexPath.row] == "About FarmPe"){
            SettingsVC.webViewData = "AboutUs"
            performSegue(withIdentifier: "SettingToHSPA", sender: self)
            
        } else if(settingsMenu[indexPath.row] == "Policies"){
            SettingsVC.webViewData = "Policies"
            performSegue(withIdentifier: "SettingToHSPA", sender: self)
            
        }else if(settingsMenu[indexPath.row] == "Your Address"){
            performSegue(withIdentifier: "youToAddAddress", sender: self)
            
        } else if(settingsMenu[indexPath.row] == "LogOut" ){
            performSegue(withIdentifier: "settingToLogOut", sender: self)
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingListTableView.dequeueReusableCell(withIdentifier: "settings", for: indexPath) as! SettingsTableViewCell
        if settingmenuImages.count > 0 {
            cell.imageOfSettingList.image = settingmenuImages[indexPath.row]
            cell.optionsNameLbl.text = settingsMenu[indexPath.row]
        }
        return cell
    }
}
