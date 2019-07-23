//
//  HomeVC.swift
//  Farmer
//
//  Created by Apple on 12/06/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import Alamofire

class HomeVC: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var menuBarBtn: UIBarButtonItem!
    @IBOutlet weak var addBarBtn: UIBarButtonItem!
    @IBOutlet weak var notificationBarBtn: UIBarButtonItem!
    @IBOutlet weak var infoSegment: UISegmentedControl!
    
    @IBOutlet weak var lookingForView: UIView!
    @IBOutlet weak var farmsView: UIView!
    @IBOutlet weak var farmerView: UIView!
    
    @IBOutlet weak var lookingForCollectionView: UICollectionView!
    @IBOutlet weak var farmsCollectionView: UICollectionView!
    @IBOutlet weak var farmerCollectionView: UICollectionView!
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var sideMenuConstraints: NSLayoutConstraint!
    
    @IBOutlet weak var menuListView: UIView!
    @IBOutlet weak var personalInfoView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userNumber: UILabel!
    
    @IBOutlet weak var menuTableView: UITableView!
    
    var slideMenuStatus = Bool()
    
    var lookingForArr = NSArray()
    var farmsList = NSArray()
    var farmersList = NSArray()
    
    static var lookForId = Int()
    static var farmId = Int()
    static var farmerId = Int()
    
    let menuList = ["Create New Request", "Your Requests","Invitations", "List Your Farm","Your Farms","Settings"]
    
    var settingsImage :[UIImage] =  [UIImage(named: "creatNewRequest_64")!,
                                  UIImage(named: "yourRequest")!,
                                  UIImage(named: "invitation")!,
                                  UIImage(named: "Farmlist")!,
                                  UIImage(named: "yourfarms")!,
                                  UIImage(named: "settings-1")!]

//
//    var farmsNameList = ["Amrutha Dairy Farms","Amrutha Dairy Farms", "Amrutha Dairy Farms", "Amrutha Dairy Farms"]
//    var farmsInfoList = ["Commerical Dairy Farming, Training Consulting, Project Reporting", "Commerical Dairy Farming, Training Consulting, Project Reporting", "Commerical Dairy Farming, Training Consulting, Project Reporting", "Commerical Dairy Farming, Training Consulting, Project Reporting"]
//    var farmPlaceList = ["Halenahalli, Doddabalapura", "Halenahalli, Doddabalapura", "Halenahalli, Doddabalapura", "Halenahalli, Doddabalapura"]
//
//    var nameOfFarmer = ["Jagdish Kumar", "Mallikarjun Ragi", "Ravi Kumar Hattikal", "Manoj Kumar"]
//    var inforOfFarmer = ["3rd Generation Farmer", "Rancher, Agripreneur, Farmer", "3rd Generation Farmer", "3rd Generation Farmer"]
//
//    var cropOfFarmer  = ["Paddy, Sugarcane, Wheat", "Cotton, Onion, Organic Products", "Paddy, Sugarcane, Wheat", "Paddy, Sugarcane, Wheat"]
//
//    var listOfVehicles = ["Tractor Price", "Tractor Implements Price","Tractor Accessories Price", "Tractor Price"]
//    var InfoListOfVehicle = ["Mahindra Jivo 225Dl, 20hp Immediately", "Mahindra Jivo 225Dl, 20hp 1 Month","Mahindra Jivo 225Dl, 20hp 15 Days", "Mahindra Jivo 225Dl, 20hp 3 Months"]
//    var farmerNameList = ["Jagdish Kumar", "Jagdish Kumar", "Jagdish Kumar", "Jagdish Kumar"]
//    var placeListLookingFor = ["Rampura,Bahjoi","Rampura,Bahjoi", "Rampura,Bahjoi", "Rampura,Bahjoi"]
//    var imageList:[UIImage] = [UIImage(named: "GreenTracker")!,
//                               UIImage(named: "gyrovator (1)")!,
//                               UIImage(named: "Aayushmaan1(Rear)")!,
//                               UIImage(named: "RedTractor")!]
//
//    var farmImages : [UIImage] = [UIImage(named: "cow")!,
//                                  UIImage(named: "cow")!,
//                                  UIImage(named: "cow")!,
//                                  UIImage(named: "cow")!]
//
//    var farmerpics :[UIImage] =  [UIImage(named: "jk")!,
//                                  UIImage(named: "ragi-sir")!,
//                                  UIImage(named: "ravi")!,
//                                  UIImage(named: "manoj")!]
    
    override func viewWillAppear(_ animated: Bool) {
        var nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
        let yourBackImage = UIImage(named: "leftArrow_24")//"whiteLeftArrow")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        
        userName.text = LoginVC.userInfo.value(forKey: "UserName") as? String
        userNumber.text = LoginVC.userInfo.value(forKey: "UserPhoneNum") as? String
        
        infoSegment.addUnderlineForSelectedSegment()
        shadowView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        shadowView.isHidden = true
        
        slideMenuStatus = false
        sideMenuConstraints.constant = -280
        
        userImage.layer.cornerRadius = userImage.frame.width / 2
        userImage.clipsToBounds = true
        
//        getLookingsList()
//        getFarmsList()
//        getFarmerList()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomeVC.handleTap(gestureRecognizer:)))
        gestureRecognizer.delegate = self
        shadowView.addGestureRecognizer(gestureRecognizer)

    }
    
    @objc func handleTap(gestureRecognizer: UIGestureRecognizer) {
        returnMenuView()
    }
    
    func returnMenuView(){
        sideMenuConstraints.constant = -280
        shadowView.isHidden = true
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        returnMenuView()

        if(menuList[indexPath.row] == "Settings") {
            let backItem = UIBarButtonItem()
            backItem.title = " "
            navigationItem.backBarButtonItem = backItem
            performSegue(withIdentifier: "settingList", sender: self)
            
        } else if(menuList[indexPath.row] == "Your Farms"){
            let backItem = UIBarButtonItem()
            backItem.title = "Yours Farms"
            navigationItem.backBarButtonItem = backItem
            performSegue(withIdentifier: "farms", sender: self)
            
        } else if(menuList[indexPath.row] == "Your Requests"){
            let backItem = UIBarButtonItem()
            backItem.title = "Your Request"
            navigationItem.backBarButtonItem = backItem
            performSegue(withIdentifier: "yourRequest", sender: self)
            
        } else if(menuList[indexPath.row] == "Create New Request"){
            let backItem = UIBarButtonItem()
            backItem.title = " "
            navigationItem.backBarButtonItem = backItem
            performSegue(withIdentifier: "add", sender: self)
            
        } else if(menuList[indexPath.row] == "List Your Farm"){
            performSegue(withIdentifier: "listFarms", sender: self)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = menuTableView.dequeueReusableCell(withIdentifier: "menuList", for: indexPath) as! MenuListTableViewCell
        cell.menuNameLbl.text = menuList[indexPath.row]
        cell.menuImage.image = settingsImage[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == lookingForCollectionView){
            return lookingForArr.count
        } else if(collectionView == farmsCollectionView){
            return farmsList.count
        } else{
            return farmersList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == lookingForCollectionView){
            let cell = lookingForCollectionView.dequeueReusableCell(withReuseIdentifier: "LookingFor", for: indexPath) as! LookingForCollectionViewCell
            let imgURL = URL(string: ((lookingForArr[indexPath.item] as? AnyObject)?.value(forKey: "ModelImage") as? String)!)
            if(imgURL != nil){
                if let imageData = try? Data(contentsOf: imgURL!){
                    let img : UIImage = UIImage(data: imageData)!
                    cell.imageOfItem.image = img
                }
            }
            let address = (lookingForArr[indexPath.item] as? AnyObject)?.value(forKey: "Address") as? NSDictionary
            let location = "\(address!.value(forKey: "District") as! String), \(address!.value(forKey: "State") as! String)"
            cell.farmerName.text = address?.value(forKey: "Name") as? String
            cell.itemName.text = (lookingForArr[indexPath.item] as? AnyObject)?.value(forKey: "LookingForDetails") as! String
            cell.itemInformation.text = (lookingForArr[indexPath.item] as? AnyObject)?.value(forKey: "Model") as? String
            
            cell.location.setTitle(location, for: .normal)
            return cell
        }
        else if(collectionView == farmsCollectionView){
            let cell = farmsCollectionView.dequeueReusableCell(withReuseIdentifier: "Farms", for: indexPath) as! FarmsCollectionViewCell
            
            let imgURL = URL(string: ((farmsList[indexPath.item] as? AnyObject)?.value(forKey: "FarmImages") as? String)!)
            if(imgURL != nil){
                if let imgData = try? Data(contentsOf: imgURL!){
                    let img : UIImage = UIImage(data: imgData)!
                    cell.imageOfItem.image = img
                }
            }
            cell.farmerName.text = (farmsList[indexPath.item] as? AnyObject)?.value(forKey: "ContactPersonName") as? String
            cell.itemName.text = (farmsList[indexPath.item] as? AnyObject)?.value(forKey: "FarmType") as? String
           // cell.itemInformation.text = (farmsList[indexPath.item] as? AnyObject)?.value(forKey: "FarmType") as? String
            cell.location.setTitle((farmsList[indexPath.item] as? AnyObject)?.value(forKey: "Location") as? String, for: .normal)
            return cell
            
        } else {
            let cell = farmerCollectionView.dequeueReusableCell(withReuseIdentifier: "Farmer", for: indexPath) as! FarmerCollectionViewCell
            
            let imgURL = URL(string: ((farmersList[indexPath.item] as? AnyObject)?.value(forKey: "FarmerPhoto") as? String)!)
            if(imgURL != nil){
                if let imgData = try? Data(contentsOf: imgURL!){
                    let img : UIImage = UIImage(data: imgData)!
                    cell.imageOfItem.image = img
                }
            }
            cell.farmerName.text = (farmersList[indexPath.item] as? AnyObject)?.value(forKey: "EducationQualification") as? String
            cell.itemName.text = (farmersList[indexPath.item] as? AnyObject)?.value(forKey: "FarmerName") as? String
            cell.itemInformation.text = (farmersList[indexPath.item] as? AnyObject)?.value(forKey: "FarmerType") as? String
            let village = (farmersList[indexPath.item] as? AnyObject)?.value(forKey: "Village") as? String
            let state = (farmersList[indexPath.item] as? AnyObject)?.value(forKey: "State") as? String
            var location = String()
            if((village?.isEmpty)! || village == "") || ((state?.isEmpty)! || village == ""){
                location = village! + state!
                cell.location.setTitle(location, for: .normal)
            }
            else{
                location = village! + "," + state!
                cell.location.setTitle(location, for: .normal)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == lookingForCollectionView){
            HomeVC.lookForId = ((lookingForArr[indexPath.item] as AnyObject).value(forKey: "Id") as? Int)!
        }
        else if(collectionView == farmsCollectionView){
            HomeVC.farmId = ((farmsList[indexPath.item] as AnyObject).value(forKey: "Id") as? Int)!
        }
        else if(collectionView == farmerCollectionView){
            //HomeVC.lookingForId = (lookingForArr[indexPath.item] as AnyObject).value(forKey: "Id") as? Int
        }
    }
    
//    func getLookingsList() {
//        APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: UIActivityIndicatorView.Style.whiteLarge)
//        self.view.isUserInteractionEnabled = false
//
//        Alamofire.request(APIListForXohri.getLookingsForList, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {(response:DataResponse<Any>) in
//            switch response.result{
//
//            case .success(_):
//                let res = response.result.value as? NSDictionary
//                self.lookingForArr = (res?.value(forKey: "LookingForList") as? NSArray)!
//                self.lookingForCollectionView.reloadData()
//
//                APIListForXohri.hideActivityIndicator()
//                self.view.isUserInteractionEnabled = true
//
//            case .failure(_):
//                print("getLookingsList service call failed in HomeVC:",response.result.value)
//                APIListForXohri.hideActivityIndicator()
//                self.view.isUserInteractionEnabled = true
//            }
//        }
//    }
    
//    func getFarmsList(){
//        APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: UIActivityIndicatorView.Style.whiteLarge)
//        self.view.isUserInteractionEnabled = false
//        Alamofire.request(APIListForXohri.getFarmsList, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {(response:DataResponse<Any>) in
//            switch response.result{
//
//            case .success(_):
//                let res = response.result.value as? NSDictionary
//                self.farmsList = (res?.value(forKey: "FarmsList") as? NSArray)!
//                APIListForXohri.hideActivityIndicator()
//                self.view.isUserInteractionEnabled = true
//            case .failure(_):
//                print("Printing getFarmsList service response in HomeVC:",response.result.value)
//                APIListForXohri.hideActivityIndicator()
//                self.view.isUserInteractionEnabled = true
//            }
//        }
//    }
    
//    func getFarmerList(){
//        Alamofire.request(APIListForXohri.farmerList, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON {(response: DataResponse<Any>) in
//            switch response.result{
//
//            case .success(_):
//                let res = response.result.value as? NSDictionary
//                print("Printing getFarmerList service response in HomeVC:",res)
//                self.farmersList = (res?.value(forKey: "FarmersList") as? NSArray)!
//                APIListForXohri.hideActivityIndicator()
//                self.view.isUserInteractionEnabled = true
//
//            case .failure(_):
//                print("getFarmerList service call failed in HomeVC:",response.result.value)
//            }
//        }
//    }

    @IBAction func actioninfoSegment(_ sender: UISegmentedControl) {
        infoSegment.changeUnderlinePosition()
        switch infoSegment.selectedSegmentIndex {
        case 0:
            lookingForView.isHidden = false
            farmsView.isHidden = true
            farmerView.isHidden = true
            lookingForCollectionView.reloadData()
            
        case 1:
            lookingForView.isHidden = true
            farmsView.isHidden = false
            farmerView.isHidden = true
            farmsCollectionView.reloadData()
            
        case 2:
            lookingForView.isHidden = true
            farmsView.isHidden = true
            farmerView.isHidden = false
            farmerCollectionView.reloadData()
            
        default:
            break;
        }
    }
    
    @IBAction func addBarBtn(_ sender: UIBarButtonItem) {
        
       returnMenuView()
        
        let backItem = UIBarButtonItem()
        backItem.title = "Select Category"
        navigationItem.backBarButtonItem = backItem
        
        performSegue(withIdentifier: "add", sender: self)
    }
    
    @IBAction func notificationBarBtn(_ sender: UIBarButtonItem) {
        let backItem = UIBarButtonItem()
        backItem.title = " "
        navigationItem.backBarButtonItem = backItem
        performSegue(withIdentifier: "HomeToNotify", sender: nil)
    }
    
    @IBAction func searchBarBtnA(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func menubarBtnA(_ sender: UIBarButtonItem) {
        if(slideMenuStatus == true){
            sideMenuConstraints.constant = -280
            shadowView.isHidden = true
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        } else {
            sideMenuConstraints.constant = 0
            shadowView.isHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        slideMenuStatus = !slideMenuStatus
    }
   
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
       returnMenuView()
        performSegue(withIdentifier: "DetailPage", sender: self)
    }
}

extension UISegmentedControl{
    func removeBorder(){
        let backgroundImage = UIImage.getColoredRectImageWith(color: UIColor.black.cgColor, andSize: self.bounds.size)
        self.setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .selected, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .highlighted, barMetrics: .default)
        let deviderImage = UIImage.getColoredRectImageWith(color: UIColor.black.cgColor, andSize: CGSize(width: 1.0, height: self.bounds.size.height))
        
        self.setDividerImage(deviderImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes(NSDictionary(objects: [UIFont.systemFont(ofSize: 17.0)], forKeys: [NSAttributedString.Key.font as NSCopying]) as? [NSAttributedString.Key : Any], for: UIControl.State.normal)
    }
    
    func addUnderlineForSelectedSegment(){
        removeBorder()
        let underlineWidth: CGFloat = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let underlineHeight: CGFloat = 2.5
        let underlineXPosition = CGFloat(selectedSegmentIndex * Int(underlineWidth))
        let underLineYPosition = self.bounds.size.height - 1.0
        let underlineFrame = CGRect(x: underlineXPosition, y: underLineYPosition, width: underlineWidth, height: underlineHeight)
        let underline = UIView(frame: underlineFrame)
        underline.backgroundColor = UIColor.white
        underline.tag = 1
        self.addSubview(underline)
    }
    
    func changeUnderlinePosition(){
        guard let underline = self.viewWithTag(1) else {return}
        let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)
        UIView.animate(withDuration: 0.1, animations: {
            underline.frame.origin.x = underlineFinalXPosition
        })
    }
}
