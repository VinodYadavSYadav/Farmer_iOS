//
//  ComposeVC.swift
//  Farmer
//
//  Created by Apple on 04/06/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import Alamofire

class ComposeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var sideContraintsOfMenuView: NSLayoutConstraint!
    @IBOutlet weak var composeLbl: UILabel!
    @IBOutlet weak var viewwithNameImage: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var trendingBtn: UIButton!
    @IBOutlet weak var inventoryBtn: UIButton!
    @IBOutlet weak var sellBtn: UIButton!
    @IBOutlet weak var orderBtn: UIButton!
    @IBOutlet weak var youBtn: UIButton!
    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var ListofCategoryCollectionView: UICollectionView!
    
    var slideMenuStatus =  Bool()
    var vegNameList = ["tomato, Carrot"]
    
    var collectionView: UICollectionView?
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    var CatagoryList = NSArray()
    var catagories = NSDictionary()
    static var idOfCatagory = Int()
    static var categoryImage = String()
    static var completDetailsOfCrop = NSMutableDictionary()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (screenWidth/3), height: (screenWidth/3))
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 2
        
        ListofCategoryCollectionView!.collectionViewLayout = layout
        
        shadowView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        shadowView.isHidden = true
        
        slideMenuStatus = false
        sideContraintsOfMenuView.constant = -240
        
        if(APIListForXohri.isInternetAvailable() == false) {
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Check Your Internet Connection!!!")
            
        } else {
            listOfCategoriesFuncCall()
            
        }
        
        if(ForgotPasswordVC.PhNumStatus == 3){
            userName.text = "Welcome, " + UserDefaults.standard.string(forKey: "UserName")!
            
        } else if(ForgotPasswordVC.PhNumStatus == 2){
            userName.text = "Welcome, " +  UserDefaults.standard.string(forKey: "UserName1st")!
            
        }
    }
    
    func listOfCategoriesFuncCall() {
        
        APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: UIActivityIndicatorView.Style.gray)
        self.view.isUserInteractionEnabled = false
        
        Alamofire.request(APIListForXohri.getCategories, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success:
                if let data = response.result.value {
                    let jsonData = data as! NSDictionary
                    self.CatagoryList = jsonData.value(forKey: "CatagoryList") as! NSArray
                    APIListForXohri.hideActivityIndicator()
                    self.view.isUserInteractionEnabled = true
                    self.ListofCategoryCollectionView.reloadData()
                }
            case .failure:
                APIListForXohri.hideActivityIndicator()
                self.view.isUserInteractionEnabled = true
                break
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CatagoryList.count
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let backItem = UIBarButtonItem()
        backItem.title = "Select Crop"
        navigationItem.backBarButtonItem = backItem
        
        ComposeVC.idOfCatagory = (CatagoryList[indexPath.item]as AnyObject).value(forKey: "Id") as! Int
        
        ComposeVC.categoryImage = (CatagoryList[indexPath.item] as AnyObject).value(forKey: "CatagoryIcon") as? String ?? ""
        
        
        ComposeVC.completDetailsOfCrop.setValue(((CatagoryList[indexPath.item] as AnyObject).value(forKey: "Catagory") as? String ?? ""), forKey: "NameOfCategories")
        ComposeVC.completDetailsOfCrop.setValue(((CatagoryList[indexPath.item] as AnyObject).value(forKey: "CatagoryIcon") as? String ?? ""), forKey: "ImageOfCategories")
        
        performSegue(withIdentifier: "selecteCrop", sender: self)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ListofCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "Categories", for: indexPath)as! ComPoseCollectionViewCell
        cell.nameOfVeg.text = (CatagoryList[indexPath.item] as AnyObject).value(forKey: "Catagory") as? String ?? ""
        let imageOfLang:String = (self.CatagoryList[indexPath.item] as AnyObject).value(forKey: "CatagoryIcon") as? String ?? ""
        
        let newVal = imageOfLang.replacingOccurrences(of: "\\", with: "/")
        let urls = URL(string: newVal)
        if(urls != nil) {
            let data = try? Data(contentsOf: urls!)
            if let imageData = data {
                let image = UIImage(data: imageData)
                cell.imageOfVeg.image = image
            }
        }
        
        return cell
    }
    
    @IBAction func trendingBtnAction(_ sender: UIButton) {
        performSegue(withIdentifier: "SellPageToTrendingPage", sender: self)
    }
    @IBAction func inventoryBtnAction(_ sender: UIButton) {
        performSegue(withIdentifier: "composeToInventory", sender: self)
    }
    @IBAction func sellBtnAction(_ sender: UIButton) {
        sideContraintsOfMenuView.constant = -240
        shadowView.isHidden = true
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    @IBAction func orderBtnAction(_ sender: UIButton) {
        performSegue(withIdentifier: "composeToOrders", sender: self)
    }
    @IBAction func youBtnAction(_ sender: UIButton) {
        performSegue(withIdentifier: "ComposeToYou", sender: self)
    }
    
    @IBAction func tapGesture(_ sender: Any) {
        
        sideContraintsOfMenuView.constant = -240
        shadowView.isHidden = true
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        
    }
    @IBAction func homeBtnAction(_ sender: UIButton) {
        performSegue(withIdentifier: "composeToHome", sender: self)
    }
}
