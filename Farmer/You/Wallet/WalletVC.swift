//
//  WalletVC.swift
//  Xohri
//
//  Created by Apple on 28/03/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import Alamofire

class WalletVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    @IBOutlet weak var imageOfCoins: UIImageView!
    @IBOutlet weak var rupeesLbl: UILabel!
    @IBOutlet weak var walletTableView: UITableView!
    @IBOutlet weak var rechargeBtn: UIButton!
    @IBOutlet weak var buyCoinLbl: UILabel!
    
    var rechargeBtnStatus = Bool()
    var coinsList = ["100 Coins","500 Coins","2000 Coins","5000 Coins","10000 Coins",]
    var rupeesList = ["Rs.80","Rs.400","Rs.1500","Rs.4200","Rs.8200",]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rechargeBtn.layer.cornerRadius = 3
        
        rechargeBtnStatus = true
        walletTableView.isHidden = true
        buyCoinLbl.isHidden = true


    }
    override func viewDidAppear(_ animated: Bool) {
        if(APIListForXohri.isInternetAvailable() == false) {
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Check Your Internet Connection!!!")
            
        } else {
            
            walletBalance()
        }
    }
    
    func walletBalance() {
        APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: UIActivityIndicatorView.Style.gray)
        self.view.isUserInteractionEnabled = false
        
        let param: [String: Any] = [
            "UserId" : UserDefaults.standard.integer(forKey: "UserId")
            ]
        
        Alamofire.request(APIListForXohri.walletBalance, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [:]).responseJSON {(responds:DataResponse<Any>) in
            switch responds.result {
                
            case .success(_):
                if let data = responds.result.value {
                    let jsonData = data as! NSDictionary
                    self.rupeesLbl.text = "\(jsonData.value(forKey: "BalanceAmount") as? Int ?? 0)"
                }
                
                APIListForXohri.hideActivityIndicator()
                self.view.isUserInteractionEnabled = true
                break
                
            case .failure(_):
                APIListForXohri.hideActivityIndicator()
                self.view.isUserInteractionEnabled = true
                break
            }
        }
        APIListForXohri.hideActivityIndicator()
        self.view.isUserInteractionEnabled = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coinsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = walletTableView.dequeueReusableCell(withIdentifier: "wallet", for: indexPath)as! WalletTableViewCell
        
        walletTableView.tableFooterView = UIView(frame: .zero)
        
        cell.moneyBtn.setTitle(rupeesList[indexPath.row], for: .normal)
        cell.rupeesLbl.text = coinsList[indexPath.row]
        cell.moneyBtn.layer.cornerRadius = 3
        
        return cell
        
    }
    
    @IBAction func rechargeBtnAction(_ sender: UIButton) {
        
        if(rechargeBtnStatus == false) {
            walletTableView.isHidden = true
            buyCoinLbl.isHidden = true
            
        } else {
            walletTableView.isHidden = false
            buyCoinLbl.isHidden = false
            rechargeBtn.isHidden = true
            
        }
    }
    
}
