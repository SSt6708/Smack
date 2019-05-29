//
//  AvatarPickVC.swift
//  Smack
//
//  Created by Steven Liu on 2019/5/26.
//  Copyright © 2019 Steven Liu. All rights reserved.
//

import UIKit

class AvatarPickVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    

    //Outlets
    @IBOutlet weak var segController: UISegmentedControl!
    
    @IBOutlet weak var CollectionView: UICollectionView!
    
    //variables
    var avatarType = AvatarType.dark
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CollectionView.delegate = self
        CollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segControllerChanged(_ sender: Any) {
        
        if segController.selectedSegmentIndex == 0{
            
            avatarType = AvatarType.dark
            
            
        }else{
            
            avatarType = AvatarType.light
        }
        
        
        CollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var numOfCollumns : CGFloat = 3
        
        if UIScreen.main.bounds.width > 320 {
            numOfCollumns = 4
        }
        let spaceBetweenCells : CGFloat = 10
        let padding : CGFloat = 40
        let cellDimension = ((collectionView.bounds.width - padding) - (numOfCollumns - 1) * spaceBetweenCells) / numOfCollumns
        
        
        return CGSize(width: cellDimension, height: cellDimension)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if avatarType == .dark{
            UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
        }else{
            UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell{
            
            cell.configureCell(index: indexPath.item, type: avatarType)
            
            
            return cell
        }
        
        
        return AvatarCell()
    }
    
    

}
