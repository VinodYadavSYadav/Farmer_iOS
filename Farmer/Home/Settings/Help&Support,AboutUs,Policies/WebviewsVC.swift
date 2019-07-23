//
//  WebviewsVC.swift
//  Farmer
//
//  Created by Apple on 18/06/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import WebKit

class WebviewsVC: UIViewController {
    
    @IBOutlet weak var webViewForAll: WKWebView!
    var urlString : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(SettingsVC.webViewData == "HelpAndSupport"){
            self.navigationItem.title = "Help & Support"
            urlString = "http://farmpe.in/help-support.html"
            
        } else if(SettingsVC.webViewData == "AboutUs"){
           self.navigationItem.title = "About FarmPe"
            urlString = "http://farmpe.in/about-us.html"

        } else if(SettingsVC.webViewData == "Policies"){
            self.navigationItem.title = "Policies"
            urlString = "http://farmpe.in/privacy.html"
            
        }
        
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webViewForAll.load(request)
        }
        
    }

}
