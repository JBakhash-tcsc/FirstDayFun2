//
//  ViewController.swift
//  2nd day fun
//
//  Created by Jonathan on 7/22/20.
//  Copyright © 2020 Jonathan. All rights reserved.
//

import UIKit
import SpriteKit


var serves = 0;



//outlet area


var totalserves = "Total Serves: "

var serveInfo = [180, 7, 22 ]


var playerNames = ["Bob", "Joe","Wendy", "Roj" ]

// This is creating an array without any elements in it
// we're simply stating what data type is going to be inside the array

var balls = [Int]()

// Array Literal    0  1   2   3
class ViewController: UIViewController {
    
    // Class Scope Level Variables
 //                     0      1       2     3     4       5     6 
    let scoreInfo = ["Love",  "15",  "30", "40"]
    //                    0       1     2
    let scoreEndInfo = ["DUCE", "ADV", "-"]
    

    //outlet
    @IBOutlet weak var Pgames: UILabel!
    
    //connect to the view
    
    @IBOutlet weak var SK: SKView!
    
    //lets connect to the players game points
    
    @IBOutlet weak var playergpoutlet: UILabel!
    
    @IBOutlet weak var computergpoutlet: UILabel!
    
    
    @IBOutlet weak var servesLabel: UILabel!
    
    
    
    @IBAction func newballbutton(_ sender: Any) {
        
        print("new ball")
        
        ball.size.width = ballOrigWidth
        ball.size.height = ballOrigHeight
    }
    
    @IBOutlet weak var totalServesLabel: UILabel!
    
    @IBAction func goserve(_ sender: Any) {
        
        
        
        
        
        
        print("the number of serves are\(serves)")
          
        serves+=1
        
        servesLabel.text = String (serves)
        
        
        totalServesLabel.text = "\(totalserves) \(serves)"
        
    }
    
    
    
    @IBOutlet weak var totalserveslabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //connect to myscene ....
        let scene = Myscene(size:CGSize(width: 192, height: 440))
        scene.scaleMode = .aspectFill
        SK.presentScene(scene)
        
        
        servesLabel.text = String (serves)
        
       totalServesLabel.text = "\(totalserves) \(serves)"
        
        
        
        print("\n Prepare to show serveInfo...")
        print("serveInfo at the index of zero:  \(serveInfo[0])")
        print("serveInfo at the index of one:   \(serveInfo[1])")
        print("\n Team Number 1")
        print("Doubles Match!")
        print("Team1: Player 1 \(playerNames[0])")
        print("Team 1: Player 2 \(playerNames[1])")
        
        print("\n Team Number 2")
        print("Team 2: Player 1 \(playerNames[2])")
        print("Team 2 Player 2 \(playerNames[3])")
        print("\nThe count of elements in the serveInfo array is: \(playerNames.count)")
        print("The count of elements in the playerNames array is: \(playerNames.count)")
        
        print("The count of elements in the balls array is: \(balls.count)")
        
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats:true) { (timer) in
        
            // Do what you need to do repeatedly
            
            //semantic reference to self... is required
            // because we're in a closure / callback
            self.displayScores()
        //end of the timer...
        }
//end of the viewDidLoad method
    }
    
    func getScoreDiff() -> Bool  {
        
        // the player has received a point
        
     //   playerScore[2] += 1
        let points      = playerScore[2]
        let aiPoints     = computerScore[2]
        if ( points > 3) || (aiPoints > 3) {
            //the player just won a game!
     
                
            let diff = points - aiPoints
                
            if (diff >= 2 ) {
                
                //at this pointwe know the player won the game!
                //because the ai didn't make it to 40
                
                // reset the player's points
                playerScore[2] = 0
                //player won a game
                playerScore[1] += 0
                
                //reset the computers's points but don't give him a game
                computerScore[2] = 0
                
                print ("The Human Player won a game!")
                
            }// player points minus ai pints is exactly one!
            else if( diff == 1) {

               
               playergpoutlet.text = "ADV"
               computergpoutlet.text = " - "
            
            }
            else if diff == 0 {
                playergpoutlet.text = "DUCE"
                computergpoutlet.text = "DUCE"
            }
            else if diff == -1 {
                playergpoutlet.text = " - "
                computergpoutlet.text = "ADV"
            }
  
            else {
                computerScore[2] = 0
                playerScore[2] = 0
                computerScore[1] += 1
            }
            
            // this means we will return true if someone got more than 3 points :D
            return true;
            
         //end of the diff being greater than 3 check
        }
        
        //default return .. meaning if no other returns take place it does this
            return false
     // end of the get score diff method
        
    }
            
                                   
    
    
    func displayScores(){
        // this is the raw score as an integer
              
       let pScore = playerScore[2]
       let cScore = computerScore[2]
        
        // should we use the modified scoring system
        // because someone has 40 or more points?
    if !getScoreDiff() {
        
        let pVal = scoreInfo[pScore]
        let cVal = scoreInfo[cScore]
        
        
        playergpoutlet.text = scoreInfo[pScore]
        computergpoutlet.text = scoreInfo[cScore]
    
        }
        //this is the score represented as a string...
      
        
       
    }

}


