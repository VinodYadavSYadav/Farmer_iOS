//
//  BrandVC.swift
//  Farmer
//
//  Created by Apple on 14/06/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import Alamofire

class BrandVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var brandCollectionView: UICollectionView!
    
    var brandList = NSArray()
    static var brandListId = Int()
    
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
    var listOfVehicles = ["Mahindra", "Sonalika","Eicher Tractors", "John Deere", "Escort", "Swaraj","Mahindra", "Sonalika","Eicher Tractors", "John Deere", "Escort", "Swaraj"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(APIListForXohri.isInternetAvailable() == false){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Check Your Internet Connection!!!")
        }
        else {
            getBrandsList()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brandList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = brandCollectionView.dequeueReusableCell(withReuseIdentifier: "Brand", for: indexPath) as! BrandCollectionViewCell
        if(brandList.count > 0){
            let imgURL = URL(string: ((brandList[indexPath.item] as AnyObject).value(forKey: "BrandIcon") as? String)!)
            if(imgURL != nil){
                if let imgData = try? Data(contentsOf: imgURL!){
                    let img : UIImage = UIImage(data: imgData)!
                    cell.imageOfItem.image = img
                }
            }
            cell.itemName.text = (brandList[indexPath.item] as AnyObject).value(forKey: "BrandName") as! String
        }
//        cell.itemName.text = listOfVehicles[indexPath.item]
//        cell.imageOfItem.image = imageList[indexPath.item]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let backItem = UIBarButtonItem()
        backItem.title = "Select HP"
        navigationItem.backBarButtonItem = backItem
        BrandVC.brandListId = (brandList[indexPath.item] as AnyObject).value(forKey: "Id") as! Int
        performSegue(withIdentifier: "BrandToHp", sender: self)
    }
    
    func getBrandsList(){
        APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: UIActivityIndicatorView.Style.gray)
        self.view.isUserInteractionEnabled = false
        
        let param = ["LookingForDetailsId":LookingForItemVC.detailsId]
        Alamofire.request(APIListForXohri.getBrandsList, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [:]).responseJSON {(response:DataResponse<Any>) in
            switch response.result{
                
            case .success(_):
                let res = response.result.value as? NSDictionary
                self.brandList = (res?.value(forKey: "BrandList") as? NSArray)!
                self.brandCollectionView.reloadData()
                self.view.isUserInteractionEnabled = true
                APIListForXohri.hideActivityIndicator()
            case .failure(_):
                self.view.isUserInteractionEnabled = true
                APIListForXohri.hideActivityIndicator()
            }
        }
    }
}
