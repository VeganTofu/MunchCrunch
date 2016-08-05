//
//  MainViewController.swift
//  MunchCrunch
//
//  Created by Adrian Wu on 05/08/2016.
//  Copyright © 2016 VeganTofu. All rights reserved.
//

import UIKit
import SpriteKit

class MainViewController: UIViewController {
  
  @IBOutlet weak var GameView: SKView!
  let gameScene = GameScene()
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.hidden = true
    
    GameView.layoutIfNeeded()
    GameView.backgroundColor = UIColor.clearColor()
    GameView.presentScene(gameScene)
  }
  override func viewDidDisappear(animated: Bool) {
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func dismissMenu(){
    
  }
  func showMenu(){
    
  }
  
  @IBAction func leftButtonAction(sender: AnyObject) {
  }
  
  @IBAction func middleButtonAction(sender: AnyObject) {
    
  }
  
  @IBAction func rightButtonAction(sender: AnyObject) {
    
  }
  
}

