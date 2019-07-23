//
//  CategoriesVC.swift
//  Farmer
//
//  Created by Apple on 19/06/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit
import Alamofire

class CategoriesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    var lookingForList = NSArray()
    static var lookingForId = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categoriesList()
    }
    
    func categoriesList () {
        APIListForXohri.showActivityIndicator(view: self.view, spinnerColor: UIActivityIndicatorView.Style.gray)
        self.view.isUserInteractionEnabled = false
        Alamofire.request(APIListForXohri.categorylist, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
                
            case .success:
                if let data = response.result.value {
                    let jsonData = data as! NSDictionary
                    print("Printing the categories list data:", jsonData)
                    self.lookingForList = jsonData.value(forKey: "LookingForList") as! NSArray
                    self.categoriesCollectionView.reloadData()
                    APIListForXohri.hideActivityIndicator()
                    self.view.isUserInteractionEnabled = true
                }
                
            case .failure:
                APIListForXohri.hideActivityIndicator()
                self.view.isUserInteractionEnabled = true
                break
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lookingForList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "catAndSubCat", for: indexPath) as! CategoriesCollectionViewCell
        if(lookingForList.count > 0){
            let imgStr = (lookingForList[indexPath.row] as AnyObject).value(forKey: "LookingForIcon") as? String
            let newVal = imgStr?.replacingOccurrences(of: "\\", with: "/")
            let urls = URL(string: newVal!)
            if(urls != nil) {
                let data = try? Data(contentsOf: urls!)
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    cell.imageOfItem.image = image
                }
            }
            cell.itemName.text = (lookingForList[indexPath.item] as AnyObject).value(forKey: "LookingFor") as? String ?? ""
        }
        return cell
    }
    
    func collectionView(_ collectionVidew: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        CategoriesVC.lookingForId = (lookingForList[indexPath.item] as AnyObject).value(forKey: "Id") as! Int
        let barBtn = UIBarButtonItem()
        barBtn.title = "What are you looking for?"
        navigationItem.backBarButtonItem = barBtn
        performSegue(withIdentifier: "catToLookingFor", sender: self)
    }
}
