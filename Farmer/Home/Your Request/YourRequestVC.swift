//
//  YourRequestVC.swift
//  Farmer
//
//  Created by Apple on 03/07/19.
//  Copyright © 2019 Renewin. All rights reserved.
//

import UIKit

class YourRequestVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var yourRequestCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.title = "Your Request"

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = yourRequestCollectionView.dequeueReusableCell(withReuseIdentifier: "yourRequest", for: indexPath) as! YourRequestCollectionViewCell
        return cell
        
    }
    
    @IBAction func filterBtnAction(_ sender: UIButton) {
    }
    
}
