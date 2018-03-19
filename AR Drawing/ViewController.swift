//
//  ViewController.swift
//  AR Drawing
//
//  Created by Francois Schaus on 10/22/17.
//  Copyright © 2017 Francois Schaus. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    let configuration = ARWorldTrackingConfiguration()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.ARSceneViewOutlet.session.run(configuration)
        self.ARSceneViewOutlet.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.ARSceneViewOutlet.showsStatistics = true
        self.ARSceneViewOutlet.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var ARSceneViewOutlet: ARSCNView!
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        guard let pointOfView = ARSceneViewOutlet.pointOfView else {return}
        let transform = pointOfView.transform
        let orientation = SCNVector3(-transform.m31, -transform.m32, -transform.m33)
        let position = SCNVector3(transform.m41, transform.m42, transform.m43)
        let currentPositionOfCamera = plus(left: orientation, right: position)
        if draw.isHighlighted == true {
            let sphereNode = SCNNode(geometry : SCNSphere(radius: 0.02))
            sphereNode.position = currentPositionOfCamera
            self.ARSceneViewOutlet.scene.rootNode.addChildNode(sphereNode)
            sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        } else {
            
        }
    }
    
    @IBOutlet weak var draw: UIButton!
    func plus (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
    }
}

