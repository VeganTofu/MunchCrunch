//
//  GameScene.swift
//  MunchCrunch
//
//  Created by Adrian Wu on 05/08/2016.
//  Copyright © 2016 VeganTofu. All rights reserved.
//

import Foundation
import SpriteKit

enum SpriteDirection:Int {
  case left = 0
  case middle = 1
  case right = 2
}

enum BallDirection:Int {
  case left = 0
  case middle = 1
  case right = 2
}


enum CollisionCategoryType : UInt32{
  case ballCategory = 1
  case middleSpriteCategory = 2
  case wallCategory = 3
}

class Ball: SKSpriteNode {
  var hasReachedPeak :Bool = false
  var ballDirection:BallDirection?
  func setCollisionMasks(ballDirection:BallDirection){
    self.ballDirection = ballDirection
  }
  func setCollisionMasks(){
    self.physicsBody?.categoryBitMask = CollisionCategoryType.ballCategory.rawValue
    self.physicsBody?.contactTestBitMask = CollisionCategoryType.middleSpriteCategory.rawValue | CollisionCategoryType.wallCategory.rawValue
    self.physicsBody?.collisionBitMask = CollisionCategoryType.middleSpriteCategory.rawValue
  }
}

class GameScene: SKScene , SKPhysicsContactDelegate {
  var borderBody:SKSpriteNode!
  var middleSprite:SKSpriteNode!
  var simpleUpdateCount = 0
  var selectedDirection:SpriteDirection?
  
  
  override func didMoveToView(view: SKView) {
    scaleMode = .ResizeFill // make scene's size == view's size
    self.physicsWorld.contactDelegate = self
    let padding:CGFloat = 100
    borderBody = SKSpriteNode(color: UIColor.clearColor(), size: view.bounds.size)
    borderBody.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRectMake(padding * -1,-80, view.bounds.size.width + (padding * 2), view.bounds.size.height + padding))
    borderBody.physicsBody?.categoryBitMask = CollisionCategoryType.wallCategory.rawValue
    self.addChild(borderBody)
    self.physicsWorld.contactDelegate = self
    
    generateMiddleSprite()
    selectedDirection = SpriteDirection.middle
  }
  
  func changeSpriteDirection(spriteDirection:SpriteDirection){
    switch spriteDirection {
    case .left:
      break
    case .middle:
      break
      
    case .right:
      break
    }
  }
  
  func generateMiddleSprite(){
    middleSprite = SKSpriteNode(color: UIColor.greenColor(), size: CGSize(width: 200, height: 200))
    middleSprite.physicsBody = SKPhysicsBody(rectangleOfSize: middleSprite.size)
    middleSprite.physicsBody?.affectedByGravity = false
    middleSprite.physicsBody?.dynamic = false
    middleSprite.physicsBody?.categoryBitMask = CollisionCategoryType.middleSpriteCategory.rawValue
    middleSprite.physicsBody?.contactTestBitMask = CollisionCategoryType.ballCategory.rawValue
    middleSprite.physicsBody?.collisionBitMask = CollisionCategoryType.ballCategory.rawValue
    middleSprite.position = CGPoint(x: view!.bounds.size.width/2.0, y: 100)
    self.addChild(middleSprite)
  }
  
  func generateBall(){
    let ball = Ball(color: UIColor.redColor(), size: CGSize(width: 50, height: 50))
    ball.physicsBody = SKPhysicsBody(rectangleOfSize: ball.frame.size)
    ball.physicsBody?.categoryBitMask = CollisionCategoryType.middleSpriteCategory.rawValue
    ball.physicsBody?.contactTestBitMask = 0
    ball.physicsBody?.collisionBitMask = 0
    ball.position = CGPoint(x: view!.bounds.size.width/2.0, y:25)
    ball.name = "Ball"
    self.addChild(ball)
    applyImpulseAtAngle(BallDirection(rawValue: Int(arc4random()%3))!, ball: ball)
  }
  
  func applyImpulseAtAngle(directionType:BallDirection, ball:Ball){
    switch directionType {
    case .left:
      ball.physicsBody?.applyImpulse(CGVector(dx: -10, dy: 150))
    case .middle:
      ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 150))
    case .right:
      ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 150))
    }
  }
  
  
  
  override func update(currentTime: NSTimeInterval) {
    
    enumerateChildNodesWithName("Ball", usingBlock:
      { (node, stop) -> Void in
        if let ball = node as? Ball{
          
          if ball.position.y > 500{
            ball.setCollisionMasks()
          }
        }
    })
    simpleUpdateCount += 1
    if simpleUpdateCount == 100 {
      simpleUpdateCount = 0
      generateBall()
    }
    
  }
  
  func didBeginContact(contact: SKPhysicsContact) {
    let categoryMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
    switch (categoryMask) {
    case CollisionCategoryType.ballCategory.rawValue | CollisionCategoryType.middleSpriteCategory.rawValue:
      print("ball hit sprite")
      if let ball = contact.bodyB.node as? Ball {
        ball.removeFromParent()
      }
      
      break
    case CollisionCategoryType.ballCategory.rawValue | CollisionCategoryType.wallCategory.rawValue:
      if let ball = contact.bodyB.node as? Ball {
        ball.removeFromParent()
      }
      break
    default:
      print ("default")
      break
    }
    
  }
}