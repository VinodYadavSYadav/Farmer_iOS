
//
//  NearByVC.swift
//  Farmer
//
//  Created by Apple on 19/06/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit

class NearByVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var addressBtn: UIButton!
    
    @IBOutlet weak var farmOrFarmerSegment: UISegmentedControl!
    
    @IBOutlet weak var farmsView: UIView!
    @IBOutlet weak var farmerView: UIView!
    
    @IBOutlet weak var farmsCollectionView: UICollectionView!
    @IBOutlet weak var farmerCollectionView: UICollectionView!
    var farmsNameList = ["Amrutha Dairy Farms","Amrutha Dairy Farms", "Amrutha Dairy Farms", "Amrutha Dairy Farms"]

    var nameOfFarmer = ["Jagdish Kumar", "Mallikarjun Ragi", "Ravi Kumar Hattikal", "Manoj Kumar"]
    var inforOfFarmer = ["3rd Generation Farmer", "Rancher, Agripreneur, Farmer", "3rd Generation Farmer", "3rd Generation Farmer"]
    
    var cropOfFarmer  = ["Paddy, Sugarcane, Wheat", "Cotton, Onion, Organic Products", "Paddy, Sugarcane, Wheat", "Paddy, Sugarcane, Wheat"]
    var farmerNameList = ["Jagdish Kumar", "Jagdish Kumar", "Jagdish Kumar", "Jagdish Kumar"]

    var farmImages : [UIImage] = [UIImage(named: "cow")!,
                                  UIImage(named: "cow")!,
                                  UIImage(named: "cow")!,
                                  UIImage(named: "cow")!]
    
    var farmerpics :[UIImage] =  [UIImage(named: "jk")!,
                                  UIImage(named: "ragi-sir")!,
                                  UIImage(named: "ravi")!,
                                  UIImage(named: "manoj")!]
    var farmPlaceList = ["Halenahalli, Doddabalapura", "Halenahalli, Doddabalapura", "Halenahalli, Doddabalapura", "Halenahalli, Doddabalapura"]
    var farmsInfoList = ["Commerical Dairy Farming, Training Consulting, Project Reporting", "Commerical Dairy Farming, Training Consulting, Project Reporting", "Commerical Dairy Farming, Training Consulting, Project Reporting", "Commerical Dairy Farming, Training Consulting, Project Reporting"]

    override func viewDidLoad() {
        super.viewDidLoad()
        farmOrFarmerSegment.addUnderlineForSelectedSegment()

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       if(collectionView == farmsCollectionView){
            return farmsNameList.count
        } else{
            return nameOfFarmer.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == farmsCollectionView){
            let cell = farmsCollectionView.dequeueReusableCell(withReuseIdentifier: "FarmsNearBy", for: indexPath) as! FarmsNearByCollectionViewCell
            
            cell.imageOfItem.image = farmImages[indexPath.item]
            cell.farmerName.text = farmerNameList[indexPath.item]
            cell.itemName.text = farmsNameList[indexPath.item]
            cell.itemInformation.text = farmsInfoList[indexPath.item]
            cell.location.setTitle(farmPlaceList[indexPath.item], for: .normal)
            return cell
            
        } else {
            let cell = farmerCollectionView.dequeueReusableCell(withReuseIdentifier: "farmerNearBY", for: indexPath) as! FarmerNearByCollectionViewCell
            
            cell.imageOfItem.image = farmerpics[indexPath.item]
            cell.farmerName.text = cropOfFarmer[indexPath.item]
            cell.itemName.text = nameOfFarmer[indexPath.item]
            cell.itemInformation.text = inforOfFarmer[indexPath.item]
            cell.location.setTitle(farmPlaceList[indexPath.item], for: .normal)
            return cell
            
        }
        
    }
    @IBAction func actionSegment(_ sender: UISegmentedControl) {
        farmOrFarmerSegment.changeUnderlinePosition()
        
        switch farmOrFarmerSegment.selectedSegmentIndex {
        case 0:
            farmsView.isHidden = false
            farmerView.isHidden = true
            
        case 1:
            farmsView.isHidden = true
            farmerView.isHidden = false
        default:
            break;
        }
    }


}
