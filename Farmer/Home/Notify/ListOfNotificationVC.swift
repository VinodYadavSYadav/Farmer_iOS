//
//  ListOfNotificationVC.swift
//  Farmer
//
//  Created by Apple on 04/07/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit

class ListOfNotificationVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
  

    @IBOutlet weak var notifyTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Notification"

        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notifyTableView.dequeueReusableCell(withIdentifier: "notify", for: indexPath)as! NotifyTableViewCell
        return cell
        
    }
    

}
