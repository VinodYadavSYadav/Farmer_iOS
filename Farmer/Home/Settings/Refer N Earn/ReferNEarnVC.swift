//
//  ReferNEarnVC.swift
//  Farmer
//
//  Created by Apple on 18/06/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit

class ReferNEarnVC: UIViewController,  UICollectionViewDelegate, UICollectionViewDataSource  {

//    @IBOutlet weak var imageOfRnE: UIImageView!
//    @IBOutlet weak var wintxtLbl: UILabel!
    @IBOutlet weak var descTxtLbl: UILabel!
    @IBOutlet weak var copyUrlBtn: UIButton!
    @IBOutlet weak var socialMediaCV: UICollectionView!

    var socialMediaList:[UIImage] = [UIImage(named: "whatsapp")!,
                                     UIImage(named: "facebook")!,
                                     UIImage(named: "instagram")!,
                                     UIImage(named: "twitter")!]
    
    var listOfSocialMedia = ["Whatsapp", "Facebook", "Instagram", "Twitter"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Refer n Earn"
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfSocialMedia.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = socialMediaCV.dequeueReusableCell(withReuseIdentifier: "ReferAndEarn", for: indexPath) as! RandECollectionViewCell
        cell.sociaMediaName.text = listOfSocialMedia[indexPath.item]
        cell.sociaMediaImage.image = socialMediaList[indexPath.item]
        
        return cell
    }
    
    @IBAction func copyUrlBtnAction(_ sender: UIButton) {
    }
    
}
