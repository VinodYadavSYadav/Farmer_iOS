//
//  SelectModelVC.swift
//  Farmer
//
//  Created by Apple on 14/06/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import Alamofire

class SelectModelVC: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var modelCollectionView: UICollectionView!
    
    var modelArr = NSArray()
    static var modelId = Int()
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
    var modelOfVehicles = ["Yuvaraj 215 NXT", "Jivo 225 DI","Jivo 245 DI", "Jivo 225 DI","Jivo 225 DI", "Jivo 225 DI","Yuvaraj 215 NXT", "Jivo 225 DI","Jivo 245 DI", "Jivo 225 DI","Jivo 225 DI", "Jivo 225 DI"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(APIListForXohri.isInternetAvailable() == false){
            APIListForXohri.showAlertMessage(vc: self, messageStr: "Please Check Your Internet Connection!!!")
        }
        else {
            getModels()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = modelCollectionView.dequeueReusableCell(withReuseIdentifier: "model", for: indexPath) as! ModelCollectionViewCell
        if(modelArr.count > 0){
            let imgURL = URL(string: ((modelArr[indexPath.item] as AnyObject).value(forKey: "ModelImage") as? String)!)
            if let imgData = try? Data(contentsOf: imgURL!){
                let img : UIImage = UIImage(data: imgData)!
                cell.imageOfItem.image = img
            }
            cell.modelName.text = (modelArr[indexPath.item] as AnyObject).value(forKey: "Model") as? String
        }
//        cell.modelName.text = modelOfVehicles[indexPath.item]
//        cell.imageOfItem.image = imageList[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let backItem = UIBarButtonItem()
        backItem.title = "Request for Quotation"
        navigationItem.backBarButtonItem = backItem
        SelectModelVC.modelId = (modelArr[indexPath.item] as AnyObject).value(forKey: "Id") as! Int
        performSegue(withIdentifier: "ModelToQuotationRequest", sender: self)
    }
    
    func getModels(){
        APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: UIActivityIndicatorView.Style.gray)
        self.view.isUserInteractionEnabled = false

        let param = ["BrandId":BrandVC.brandListId,"HPId":SelectHpVC.selectedHP]
        Alamofire.request(APIListForXohri.getModelList, method: .post, parameters: param, encoding: JSONEncoding.default, headers: [:]).responseJSON {(response:DataResponse<Any>) in
            switch response.result{
                
            case .success(_):
                let res = response.result.value as? NSDictionary
                self.modelArr = (res?.value(forKey: "TractorList") as? NSArray)!
                self.modelCollectionView.reloadData()
                self.view.isUserInteractionEnabled = true
                APIListForXohri.hideActivityIndicator()
            case .failure(_):
                self.view.isUserInteractionEnabled = true
                APIListForXohri.hideActivityIndicator()
            }
        }
    }
}

