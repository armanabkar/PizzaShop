//
//  ARPizzaViewController.swift
//  PizzaShop
//
//  Created by Arman Abkar on 8/2/22.
//

import UIKit
import ARKit
import SceneKit

class ARPizzaViewController: UIViewController {
    
    var food: Food?
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var label: UIButton!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.topItem?.title = food?.name
        sceneView.delegate = self
        sceneView.scene = SCNScene()
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        addOmniLight()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(tapped))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    @objc func tapped(sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: sceneView)
        guard let query = sceneView.raycastQuery(from: tapLocation,
                                                 allowing: .existingPlaneGeometry,
                                                 alignment: .any) else { return }
        let results = sceneView.session.raycast(query)
        guard let hitTestResult = results.first else { return }
        let anchor = ARAnchor(transform: hitTestResult.worldTransform)
        sceneView.session.add(anchor: anchor)
        label.isHidden = true
    }
    
    @IBAction func closeTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addOmniLight() {
        let omniLightNode = SCNNode()
        omniLightNode.name = K.AR.omniLight
        omniLightNode.light = SCNLight()
        omniLightNode.light!.type = .omni
        omniLightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        omniLightNode.light!.color = UIColor.white
        self.sceneView.scene.rootNode.addChildNode(omniLightNode)
    }
    
}

extension ARPizzaViewController: ARSCNViewDelegate, ARSessionDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor:
                  ARAnchor) {
        guard !(anchor is ARPlaneAnchor) else { return }
        let scene = SCNScene(named: K.AR.pizzaModelLocation)
        let pizzaNode = (scene?.rootNode.childNode(withName: K.AR.pizza,
                                                   recursively: false))!
        node.addChildNode(pizzaNode)
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for
                  anchor: ARAnchor) {
        let omniNode = (self.sceneView.scene.rootNode.childNode(withName: K.AR.omniLight,
                                                                recursively: false))!
        omniNode.light?.intensity = (self.sceneView.session.currentFrame!.lightEstimate?.ambientIntensity)!
        omniNode.light?.temperature = (self.sceneView.session.currentFrame!.lightEstimate?.ambientColorTemperature)!
    }
    
}
