//
//  ItemViewController.swift
//  ARHome
//
//  Created by Rachel Chen on 10/8/19.
//  Copyright © 2019 Rachel Chen. All rights reserved.
//

import Foundation
import UIKit

class ItemViewController: UIViewController {
    
    @IBOutlet var itemCollectionView: UICollectionView!
    
    var itemSettings: ItemSettings!
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
      super.viewDidLoad()

      let customTabBarController = self.tabBarController as! CustomTabBarController
        itemSettings = customTabBarController.itemSettings

      itemCollectionView.dataSource = self
      itemCollectionView.delegate = self
    }
    
}

extension ItemViewController : UICollectionViewDelegate {
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        itemSettings.item = indexPath.row
        tabBarController?.selectedIndex = 0
    }
}

extension ItemViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("item count \(itemSettings.itemNames.count)")
        return itemSettings.itemNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = itemCollectionView.dequeueReusableCell(withReuseIdentifier: "itemCollectionViewCell", for: indexPath)
        print("indexPath.row: \(indexPath.row)")
        
        let nameLabel = cell.viewWithTag(1000) as! UILabel
        let str = itemSettings.itemNames[indexPath.row]
        nameLabel.text = str
        print("name label: \(nameLabel)" )
        
        return cell
    }
}
