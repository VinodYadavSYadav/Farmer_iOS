//
//  NotificationVC.swift
//  Farmer
//
//  Created by Apple on 17/06/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var notificationTableView: UITableView!
    var notificationList = ["Request for Quotation","New Farms"]
    var statusOfswitch : Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Notification Settings"

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notificationTableView.dequeueReusableCell(withIdentifier: "notification", for: indexPath) as! NotificationTableViewCell
        
        cell.callback = { (switch) -> Void in
            print("prints to undstd")
            
            if(indexPath.row == 0){
                
                print("RFW")
            } else if(indexPath.row == 1){
                print("New Farms")
            }
         
        }
        
        cell.notificationTxtLbl.text = notificationList[indexPath.row]
        
        return cell
    }
    

    

}
