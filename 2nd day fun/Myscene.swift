//
//  Myscene.swift
//  2nd day fun
//
//  Created by Jonathan on 8/12/20.
//  Copyright © 2020 Jonathan. All rights reserved.
//

import UIKit
import SpriteKit

var ball = SKSpriteNode( imageNamed: "ball")
var ballUp = false;
var ballOrigWidth = CGFloat(0.1)
var ballOrigHeight = CGFloat(0.1)

var player = SKSpriteNode(imageNamed: "racket_right")

var computer = SKSpriteNode(imageNamed: "racket_left")
var bg = SKSpriteNode( imageNamed: "court")
//  index info    0   1    2
//              [set,game,point]
var playerScore     = [0,0,0]
var computerScore = [0,0,0]

let aiSpeed = CGFloat(2.0)

var BX = 0.0;
var BY = 0.0;
// the ball has a velocity X of 0.0 --- so it moves straight up and down
var BVX = 0.0;
var BVY = 1.0;

class Myscene: SKScene {
    
    /*
     LOVE 15 30 40 Game
     0     1  2  3
     you never lose points
     
     After array is working
     40 - 40Duce -> Advantage
     
     */
    
    override func didMove(to view:SKView){
        print("move to Myscene was successfull")
        backgroundColor = SKColor.green
        // 1.A. creating a node for the backround
        bg.position = CGPoint(x: size.width * 0.5, y:size.height * 0.5)
        bg.size = CGSize(width: size.width,height: size.height)
         addChild(bg)
  
        ball.position = CGPoint(x: size.width * 0.5, y:size.height * 0.5)
        ball.size = CGSize(width: size.width / 4, height: size.width / 4)
        addChild(ball)
        
        
        ballOrigWidth = ball.size.width
        ballOrigHeight = ball.size.height
        
        player.position = CGPoint(x:size.width * 0.5,y: size.height * 0.25)
        
        computer.position = CGPoint(x: size.width * 0.5, y: size.height * 0.73)
        computer.size = CGSize(width: size.width / 5, height: size.width/5)
        addChild(computer)
        
        player.size = CGSize(width: size.width / 4, height: size.width / 4)
        addChild(player)
        
     // end of the didMove
    }
    
    //begin the randomize Ball Velocity X
    func randomBVX(){
        // this will give us a random number
        // between zero and 1.5 not inclusive on the upper bound
        //that means the biggest number can be
        // is 1.4999999999
        var temp = Double.random(in: 0..<1.5)
        
        // data types
        // wrapper classes for data types
        
        // should the ball go left?
        let goLeft = Bool.random();
        
        // If the boolean of goLeft is true
        // Then change the temp variable by -1
        if (goLeft) {
           temp *= -1
        }
        // reassign the Ball Velocity X to be
        // the value of temp :D smile
        BVX = temp
        // end of teh randomize Ball Velocity X method
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       guard let touch = touches.first else {
           return
       }
           
        let touchLocation = touch.location(in: self)
        
        player.position.x = touchLocation.x
        if player.position.x < player.size.width {
            player.position.x = player.size.width
        }
        
        player.position.y = touchLocation.y
        
        
        // What is half of the width of the player?
        let halfPlayerWidth = player.size.width / 2
        let racketRightSide = player.position.x + halfPlayerWidth
        let tooFarRight = bg.position.x + (bg.size.width / 2)
        
        
        if halfPlayerWidth >= racketRightSide {
        
            player.position.x = racketRightSide - ( player.size.width / 2)
            
        }
        let halfPlayerHeight = player.size.height / 2
        let racketBottom = player.position.y - halfPlayerWidth
        let racketTop = bg.position.y + (bg.size.height / 2) / 3
        let tooFarUp = (bg.size.height / 2) / 2
        
   
        
    
        print(racketTop)
        //print("The touch location is: \(touchLocation)")
        let ballTouch =     ball.contains(touch.location(in: self));
        let racketTouch = player.contains(touch.location(in: self));

    
        if ballTouch && racketTouch {
        print("Player hit the ball!")
            ball.position.y += player.size.height
        ballUp = true
            randomBVX()
        }
        
        if player.position.y > 240.76 {
            
            player.position.y = 240.76
        }
       
        
    
  //end of touches method do not delete!
    }
    
    // Mark: Touch Logic -> touchesBegan
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
    let touchLocation = touch.location(in: self)
    
        
        print("The touch location is: \(touchLocation)")
        

//end of the touches began method
    }
    func resetBall() {
        BVX = 0.0
        ball.position = CGPoint(x:size.width * 0.5,y: size.height * 0.5)
            ballUp = false;
          ball.size = CGSize(width: size.width / 4, height: size.width / 4)
        
    }
    


func aiUpdate() {
    
        // check for the distance between hte ai's center and the
        //ball
        
        let dist = ball.position.x - computer.position.x
        
        if( dist > 1 ) {
            
         
            computer.position.x += aiSpeed
        }
        else if ( dist < 1) {
            computer.position.x -= aiSpeed
            
    }
    
    
    
    if ( ballUp && computerHit(ball : ball, computer: computer ) ){
            
            ballUp=false
            
        }
  
    }
    
    
    
    override func update(_ currentTime: TimeInterval){
        //right now BVY will always be positive
        //since we already made a boolean to help with the work
        
       // print("Ball x position: \(ball.position.x) and Game Width is: \(size.width)")
        
        let OOBLeft = ball.position.x < 0
        if ( OOBLeft )   {
            print("The ball if out of bounds on the left alley")
            
            resetBall()
        
            if (ballUp) {
                print(" The human player hit the ball out of bounds!")
                
            // computer gets a point
                
            } else {
                
                print ("The AI hit the ball out of bounds!")
                playerScore[2] += 1
            }
            //End of OOBLeft check
        }
        
        let OOBRight = ball.position.x > size.width
        
        if (OOBRight)  {
        print("The ball is out of bounds on the right alley!")
       resetBall()
            
            
            if (ballUp) {
                print(" The human player hit the ball out of bounds!")
                
            // computer gets a point
                
            } else {
                
                print ("The AI hit the ball out of bounds!")
                playerScore[2] += 1
            }
            
        }
        if ballUp {
           ball.position.y += CGFloat(BVY)
        } else {
            ball.position.y -= CGFloat(BVY)
            // BVX may be negative OR positive
            ball.position.x += CGFloat(BVX)
        }
        
        aiUpdate()
      //  print(ball.position.y)
        
        let y_center = size.height / 2
        let y_ball = ball.position.y;
        
        var dist = abs(y_center - y_ball)
      //  print("The distance from center is: \(dist)")
    //  let ratio = dist / y_center
        //algorithm for bouncing the ball
        //  let ratio = y_center / dist
        //Meteor drop ball
        
        if (dist < 25) {
            dist = 25
        }
        
       var ratio = dist / y_center
        ratio = pow(ratio, -1)
        
        ratio *= 0.2
        
        
        let W = ballOrigWidth * ratio + 3
        let H = ballOrigWidth * ratio + 3
        
        ball.size = CGSize(width: W, height: H)
        // the ball went out of bounds on which side?
        if ball.position.y < size.height * 0 {
            resetBall()
            
         
            
            computerScore[2] += 1
            
            if ( computerScore[2] > 3) {
                computerScore[2] = 3;
            }
        }
        else if ball.position.y > size.height{
            resetBall()
            
            //what index correlates to the GAME POINT?
            // 0  1  2 ?
            
           
            
                playerScore[2] += 1
                
                if ( playerScore[2] > 3) {
                playerScore[2] = 3;
                      }
        }
      //Called berfore each fram is rendered
        
        
    }
  
 
 
    func computerHit(ball: SKSpriteNode, computer: SKSpriteNode) -> Bool {
       
        
        let inside = computer.contains(ball.position)
        if ( inside ) {
            
            print("Computer hit the ball")
            return true
            
            // randomize the ball velocity only if the computer
            // hit the ball
            randomBVX()
            
            print("Computer hit the ball!")
            return true
        }
        // default return
        return false
    //end of compuputerHit func
    }
    

// end of Myscene
}









