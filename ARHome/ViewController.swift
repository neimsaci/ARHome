//
//  ViewController.swift
//  ARHome
//
//  Created by Rachel Chen on 10/4/19.
//  Copyright © 2019 Rachel Chen. All rights reserved.
//

import UIKit
import ARKit
import RealityKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    @IBAction func clearButtonPressed(_ sender: Any) {
        clearAllFurniture()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initGestureRecognizers()
    }
    
    // Adding item to the tap position
    func initGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap))
        arView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleScreenTap(sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: arView)

        // Find all the detected planes that would intersect with
        // a line extending from where the user tapped the screen.
        let planeIntersections = arView.hitTest(
            tapLocation,
            types: [.estimatedHorizontalPlane])

        // If the closest of those planes is horizontal,
        // put the current furniture item on it.
        if !planeIntersections.isEmpty {
            addItem(hitTestResult: planeIntersections.first!)
        }
    }
    
    func addItem(hitTestResult: ARHitTestResult) {
        // Get the real-world position corresponding to
        // where the user tapped on the screen.
        let transform = hitTestResult.worldTransform
        let positionColumn = transform.columns.3
        let product = try! Entity.loadModel(named: "chair_swan")
        product.position = SIMD3<Float>(positionColumn.x, positionColumn.y, positionColumn.z)
        
        let placementAnchor = AnchorEntity(plane: .horizontal, minimumBounds: [0.1, 0.1])
        arView.scene.addAnchor(placementAnchor)
        placementAnchor.addChild(product)
    }
    
    func clearAllFurniture() {
        arView.scene.anchors.removeAll()
    }
}
