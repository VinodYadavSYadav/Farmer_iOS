//
//  SelectHpVC.swift
//  Farmer
//
//  Created by Apple on 14/06/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import Alamofire

class SelectHpVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var hpCollectionView: UICollectionView!
    
    var hpData = NSArray()
    static var selectedHP = Int()
    
    var imageList:[UIImage] = [UIImage(named: "GreenTracker")!,
                               UIImage(named: "gyrovator (1)")!,
                               UIImage(named: "Aayushmaan1(Rear)")!,
                               UIImage(named: "JCB")!,
                               UIImage(named: "Aayushmaan1(Rear)")!,
                               UIImage(named: "RedTractor")!,
                               UIImage(named: "GreenTracker")!,
                               UIImage(named: "gyrovator (1)")!,
                               UIImage(named: "Aayushmaan1(Rear)")!,
                               UIImage(named: "JCB")!,
                               UIImage(named: "Aayushmaan1(Rear)")!,
                               UIImage(named: "RedTractor")!]
    var UnitsOfVehicles = ["Upto 20HP", "21-30 HP","31-40 HP", "41-50 HP","51-60 HP", "60 HP Plus","Upto 20HP", "21-30 HP","31-40 HP", "41-50 HP","51-60 HP", "60 HP Plus"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(APIListForXohri.isInternetAvailable() == false){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Check Your Internet Connection!!!")
        }
        else {
            getHP()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hpData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = hpCollectionView.dequeueReusableCell(withReuseIdentifier: "hp", for: indexPath) as! HpCollectionViewCell
        if(hpData.count > 0){
            let imgURL = URL(string: ((hpData[indexPath.item] as AnyObject).value(forKey: "HorsePowerIcon") as? String)!)
            if(imgURL != nil){
                if let imgData = try? Data(contentsOf: imgURL!){
                    let img : UIImage = UIImage(data: imgData)!
                    cell.imageOfItem.image = img
                }
            }
            cell.unitName.text = (hpData[indexPath.item] as AnyObject).value(forKey: "HorsePowerRange") as? String
        }
//        cell.unitName.text = UnitsOfVehicles[indexPath.item]
//        cell.imageOfItem.image = imageList[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let backItem = UIBarButtonItem()
        backItem.title = "Select Model"
        navigationItem.backBarButtonItem = backItem
        SelectHpVC.selectedHP = (hpData[indexPath.item] as AnyObject).value(forKey: "Id") as! Int
        performSegue(withIdentifier: "HpToModel", sender: self)
    }

    func getHP(){
        APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: UIActivityIndicatorView.Style.gray)
        self.view.isUserInteractionEnabled = false
        let param = ["LookingForDetailsId":LookingForItemVC.detailsId]
        Alamofire.request(APIListForXohri.getHPList, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [:]).responseJSON {(response:DataResponse<Any>) in
            switch response.result{
                
            case .success(_):
                
                let res = response.result.value as? NSDictionary
                self.hpData = (res?.value(forKey: "HPList") as? NSArray)!
                self.hpCollectionView.reloadData()
                self.view.isUserInteractionEnabled = true
                APIListForXohri.hideActivityIndicator()
                
            case .failure(_):
                self.view.isUserInteractionEnabled = true
                APIListForXohri.hideActivityIndicator()
            }
        }
    }
}

