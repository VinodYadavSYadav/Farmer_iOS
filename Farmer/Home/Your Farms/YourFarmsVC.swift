//
//  YourFarmsVC.swift
//  Farmer
//
//  Created by Apple on 03/07/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit

class YourFarmsVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
   
    @IBOutlet weak var farmsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.title = "Your Farms"

    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = farmsCollectionView.dequeueReusableCell(withReuseIdentifier: "yourFarms", for: indexPath) as! YourFarmsCollectionViewCell
        return cell
    }
    

}
