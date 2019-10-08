//
//  ItemSettings.swift
//  ARHome
//
//  Created by Rachel Chen on 10/8/19.
//  Copyright © 2019 Rachel Chen. All rights reserved.
//

import Foundation
import UIKit
import ARKit
import RealityKit

class ItemSettings {
    
    let itemNames = [
        "chair",
        "guitar"
    ]
    
    var item = 0
    func currentItem() -> ModelEntity {
      switch item {
      case 0:
        return createChair()
      case 1:
        return createGuitar()
      default:
        return createChair()
      }
    }

    func createChair() -> ModelEntity {
        let item = try! Entity.loadModel(named: "chair_swan")
        return item
    }
    
    func createGuitar() -> ModelEntity {
        let item = try! Entity.loadModel(named: "fender_stratocaster")
        return item
    }
}
