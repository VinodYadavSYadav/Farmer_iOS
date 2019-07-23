//
//  SelectLanguageVC.swift
//  Xohri
//
//  Created by Apple on 11/01/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import Alamofire

protocol varietyOfLang {
    func languageSelection()
}

class SelectLanguageVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var languageTableView: UITableView!
    @IBOutlet weak var popUpView: UIView!
    
    var delegateOfLang : varietyOfLang?
    
    var LanguagesList = NSArray()
    var idOfSelectedLang = Int()
    static var statusOfSelectedLang = Int()
    static var selectedLanguage : String?
//    var LanguagesList = ["English","हिंदी","ಕನ್ನಡ","తెలుగు","தமிழ்","മലയാളം","मराठी","ગુજરાતી","ਪੰਜਾਬੀ","বাঙালি","اردو"]
   

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
        
        if(APIListForXohri.isInternetAvailable() == false) {
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Check Your Internet Connection!!!")
            
        } else {
            selectionOfLanguages()
            
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
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LanguagesList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.idOfSelectedLang = ((self.LanguagesList[indexPath.row] as AnyObject).value(forKey: "Id") as? Int)!
        
        SelectLanguageVC.selectedLanguage = (self.LanguagesList[indexPath.row] as AnyObject).value(forKey: "Language") as? String ?? "English"
        
        SelectLanguageVC.statusOfSelectedLang = 1
        if(APIListForXohri.isInternetAvailable() == false) {

            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Check Your Internet Connection!!!")

        } else {

            changeCurrentCulture()

        }
        delegateOfLang?.languageSelection()
        dismiss(animated: true, completion: nil)


    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = languageTableView.dequeueReusableCell(withIdentifier: "language", for: indexPath) as! LanguageTableViewCell
        
        languageTableView.tableFooterView = UIView(frame: .zero)
        cell.language.text = (self.LanguagesList[indexPath.row] as AnyObject).value(forKey: "Language") as? String ?? ""
        
        let langCode = (self.LanguagesList[indexPath.row] as AnyObject).value(forKey: "LangCode") as? String ?? ""
        
        let idOfLang = ((self.LanguagesList[indexPath.row] as AnyObject).value(forKey: "Id") as? Int)!
        
        let isActiveLang = ((self.LanguagesList[indexPath.row] as AnyObject).value(forKey: "IsActive") as? Int)!
        
        let imageOfLang:String = (self.LanguagesList[indexPath.row] as AnyObject).value(forKey: "ImageIcon") as? String ?? ""
//        let newVal = imageOfLang.replacingOccurrences(of: "\\", with: "/")
//        let urls = URL(string: newVal)
//        if(urls != nil) {
//            let data = try? Data(contentsOf: urls!)
//            if let imageData = data {
//                let image = UIImage(data: imageData)
//                cell.imageOfLang.image = image
//            }
//        }
        return cell
    }
    
    func selectionOfLanguages()  {
        APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: UIActivityIndicatorView.Style.gray)
        self.view.isUserInteractionEnabled = false

        Alamofire.request(APIListForXohri.getLanguages, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response:DataResponse<Any>) in

            switch(response.result) {

            case .success:
                if let data = response.result.value {
                    let jsonData = data as! NSDictionary
                    self.LanguagesList = (jsonData.value(forKey: "LanguagesList") as? NSArray)!
                    self.languageTableView.reloadData()

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
    
    func changeCurrentCulture(){
        APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: UIActivityIndicatorView.Style.gray)
        self.view.isUserInteractionEnabled = false

        let param = [
            "Id": idOfSelectedLang
        ]

        Alamofire.request(APIListForXohri.languageChange, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response:DataResponse<Any>) in

            switch(response.result) {

            case .success:
                if let data = response.result.value {

                    
                    let dictionary = data as? [String : String]
                    UserDefaults.standard.setValue(dictionary, forKey: "DictValue")
                    let dictValue =  UserDefaults.standard.value(forKey: "DictValue")
                    print("HELLO",dictValue)
                    
                    if let dataInDiffLang = data as? NSDictionary {
                        print("Prints when user clicks on particular language: ",dataInDiffLang)
                        
                        let myData = NSKeyedArchiver.archivedData(withRootObject: dataInDiffLang)
                        UserDefaults.standard.set(myData, forKey: "DataInDiffLang")

                        let recovedUserJsonData = UserDefaults.standard.object(forKey: "DataInDiffLang")
                        let recovedUserJson = NSKeyedUnarchiver.unarchiveObject(with: recovedUserJsonData as! Data)

                        
                    }
                    UserDefaults.standard.synchronize()
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
    
    func assignValue(data : NSDictionary){
        let myData = NSKeyedArchiver.archivedData(withRootObject: data)//NSKeyedArchiver.archivedData(withRootObject: myJson)
        UserDefaults.standard.set(myData, forKey: "userJson")
        
        let recovedUserJsonData = UserDefaults.standard.object(forKey: "userJson")
        let recovedUserJson = NSKeyedUnarchiver.unarchiveObject(with: recovedUserJsonData as! Data)
        
        UserDefaults.standard.set(data, forKey: "diosSession")
        UserDefaults.standard.setValue(data, forKeyPath: "userData")
    }
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.delegateOfLang!.languageSelection()

        dismiss(animated: true, completion: nil)
        
    }
//    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
//        dismiss(animated: true, completion: nil)
//    }
    
}
