//
//  SelectedCropVC.swift
//  Xohri
//
//  Created by Apple on 21/02/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import Alamofire

class SelectedCropVC: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
   
    @IBOutlet weak var selectedCropCollectionView: UICollectionView!
    
    var collectionView: UICollectionView?
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    var CropsList = NSArray()
    
    static var idOfSelectedCrop = Int()
    static var cropImage = String()

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
        
        selectedCropCollectionView!.collectionViewLayout = layout
        
        if(APIListForXohri.isInternetAvailable() == false) {
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Check Your Internet Connection!!!")
            
        } else {
            selectedCropList()
            
        }
        
    }
  
    func selectedCropList() {
        
        APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: UIActivityIndicatorView.Style.gray)
        self.view.isUserInteractionEnabled = false
        
        let selectedCrop = ["CatId": ComposeVC.idOfCatagory]
        let param = [ "Cropobj" : selectedCrop ]
        
        Alamofire.request(APIListForXohri.selectedCatagories, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success:
                if let data = response.result.value {
                    let jsonData = data as! NSDictionary
                    
                    self.CropsList = jsonData.value(forKey: "CropsList") as! NSArray
                    
                    APIListForXohri.hideActivityIndicator()
                    self.view.isUserInteractionEnabled = true
                    self.selectedCropCollectionView.reloadData()
                    
                }
            case .failure:
                APIListForXohri.hideActivityIndicator()
                self.view.isUserInteractionEnabled = true
                break
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CropsList.count

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        SelectedCropVC.idOfSelectedCrop = ((CropsList[indexPath.row]as AnyObject).value(forKey: "Id")as? Int)!
        SelectedCropVC.cropImage = (self.CropsList[indexPath.item] as AnyObject).value(forKey: "CropIcon") as? String ?? ""
        
        ComposeVC.completDetailsOfCrop.setValue(((CropsList[indexPath.row]as AnyObject).value(forKey: "CropName") as? String ?? ""), forKey: "NameOfSelectedCrop")
        ComposeVC.completDetailsOfCrop.setValue(((self.CropsList[indexPath.item] as AnyObject).value(forKey: "CropIcon") as? String ?? ""), forKey: "ImageOfSelectedCrop")
        let backItem = UIBarButtonItem()
        backItem.title = "Select Your Address"
        navigationItem.backBarButtonItem = backItem
        performSegue(withIdentifier: "addNewAddress", sender: self)
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = selectedCropCollectionView.dequeueReusableCell(withReuseIdentifier: "selectedCrop", for: indexPath) as! SelectedCropCollectionViewCell
        cell.nameOfSelectedCrop.text = (CropsList[indexPath.row]as AnyObject).value(forKey: "CropName") as? String ?? ""
        
        let imageOfLang:String = (self.CropsList[indexPath.item] as AnyObject).value(forKey: "CropIcon") as? String ?? ""
        if((imageOfLang.range(of:" ") ) != nil){
            imageOfLang.replacingOccurrences(of: " ", with: "%20")
        }
        let newVal = imageOfLang.replacingOccurrences(of: "\\", with: "/")

        let urls = URL(string: newVal)
        if(urls != nil) {
            let data = try? Data(contentsOf: urls!)
            if let imageData = data {
                let image = UIImage(data: imageData)
                cell.imageOfSelectedCrop.image = image
            }
        }

        
        return cell
        
    }
    

}
