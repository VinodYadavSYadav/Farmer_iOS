//
//  LookingForItemVC.swift
//  Farmer
//
//  Created by Apple on 13/06/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import Alamofire

class LookingForItemVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var lookingForCollectionView: UICollectionView!
    
    var detailsList = NSArray()
    static var detailsId = Int()
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
    var listOfVehicles = ["Tractor Price", "Tractor Implements Price","Tractor Accessories Price", "JCB Price","Agriculture Finance", "Agriculture insurance","Tractor Price", "Tractor Implements Price","Tractor Accessories Price", "JCB Price","Agriculture Finance", "Agriculture insurance"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(APIListForXohri.isInternetAvailable() == false){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Check Your Internet Connection!!!")
        }
        else {
            getData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = lookingForCollectionView.dequeueReusableCell(withReuseIdentifier: "lookingItem", for: indexPath) as! ItemCollectionViewCell
        
        if(detailsList.count > 0){
            let imgStr = (detailsList[indexPath.row] as AnyObject).value(forKey: "LookingForDetailsIcon") as? String
            let url = URL(string:imgStr!)
            if let data = try? Data(contentsOf: url!){
                let image: UIImage = UIImage(data: data)!
                cell.imageOfItem.image = image //imageList[indexPath.item]
            }
            cell.itemName.text = (detailsList[indexPath.row] as AnyObject).value(forKey: "LookingForDetails") as? String //listOfVehicles[indexPath.item]
        }
        //        cell.imageOfItem.image = imageList[indexPath.item]
        //        cell.itemName.text = listOfVehicles[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let backItem = UIBarButtonItem()
        backItem.title = "Select Brand"
        navigationItem.backBarButtonItem = backItem
        LookingForItemVC.detailsId = (detailsList[indexPath.item] as AnyObject).value(forKey: "Id") as! Int
        performSegue(withIdentifier: "lookingForToBrand", sender: self)
    }
    
    func getData(){
        APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: UIActivityIndicatorView.Style.gray)
        self.view.isUserInteractionEnabled = false
        
        let data = ["Id":CategoriesVC.lookingForId]
        let param = ["LookingForObj":data]
        Alamofire.request(APIListForXohri.getLookingDetail, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [:]).responseJSON {(response:DataResponse<Any>) in
            switch response.result{
                
            case .success(_):
                let res = response.result.value as? NSDictionary
                self.detailsList = (res?.value(forKey: "LookingForDetailsList") as? NSArray)!
                self.lookingForCollectionView.reloadData()
                self.view.isUserInteractionEnabled = true
                APIListForXohri.hideActivityIndicator()
                //                CategoriesVC.lookingForId = 0
                
            case .failure(_):
                self.view.isUserInteractionEnabled = true
                APIListForXohri.hideActivityIndicator()
            }
        }
    }
}
