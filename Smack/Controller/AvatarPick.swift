//
//  AvatarPick.swift
//  Smack
//
//  Created by Steven Liu on 2019/5/25.
//  Copyright © 2019 Steven Liu. All rights reserved.
//

import UIKit

class AvatarPickVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    

    //outlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentControll: UISegmentedControl!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func segConChanged(_ sender: Any) {
    }
    
    @IBAction func backPressed(_ sender: Any) {
       dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
   
}
