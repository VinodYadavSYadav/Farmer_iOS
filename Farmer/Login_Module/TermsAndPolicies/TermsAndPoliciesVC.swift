//
//  TermsAndPoliciesVC.swift
//  Farmer
//
//  Created by Apple on 19/07/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import WebKit

class TermsAndPoliciesVC: UIViewController {

    @IBOutlet weak var webViewForAll: WKWebView!
    var urlString : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlString = "http://farmpe.in/privacy.html"

        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webViewForAll.load(request)
        }
    }
    @IBAction func closeBtnAction(_ sender: UIButton) {
     dismiss(animated: true, completion: nil)
    }

}
