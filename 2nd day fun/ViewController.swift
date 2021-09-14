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
class ViewController: UIViewController, SKSceneDelegate {
    
    // Class Scope Level Variables
 //                     0      1       2     3     4       5     6 
    let scoreInfo = ["Love",  "15",  "30", "40"]
    //                    0       1     2
    let scoreEndInfo = ["DUCE", "ADV", "-"]
    

    //outlet
    @IBOutlet weak var Pgames: UILabel!
    @IBOutlet weak var Cgames: UILabel!
    
    //connect to the view
    
    @IBOutlet weak var SK: SKView!
    
    //lets connect to the players game points
    
    @IBOutlet weak var playergpoutlet: UILabel!
    
    @IBOutlet weak var computergpoutlet: UILabel!
    
    
    @IBOutlet weak var servesLabel: UILabel!
    
    
    
    @IBAction func newballbutton(_ sender: Any) {
        ball.size.width = ballOrigWidth
        ball.size.height = ballOrigHeight
    }
    
    @IBOutlet weak var totalServesLabel: UILabel!
    
    @IBAction func goserve(_ sender: Any) {
        serves+=1
        servesLabel.text = String (serves)
        totalServesLabel.text = "\(totalserves) \(serves)"
    }
    
    @IBOutlet weak var totalserveslabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = Myscene(size:SK.frame.size)
        scene.viewController = self
        scene.scaleMode = .aspectFill
        SK.presentScene(scene)
        servesLabel.text = String (serves)
        totalServesLabel.text = "\(totalserves) \(serves)"
    }
    
    func displayScores() {
        
        let points      = statsManager.playerScore[2]
        let aiPoints     = statsManager.computerScore[2]
        
        if ( points > 3) || (aiPoints > 3) {
            
            // win, advantage or deuce
                
            let diff = points - aiPoints
                
            if (diff >= 2 ) {
                // player won
                
                // reset points
                statsManager.playerScore[2] = 0
                statsManager.computerScore[2] = 0
                
                // add 1 to players games
                statsManager.playerScore[1] += 1
                
                // reset text views
                playergpoutlet.text = scoreInfo[0]
                computergpoutlet.text = scoreInfo[0]
                
                // update player games text view
                Pgames.text = String(statsManager.playerScore[1])
                
            }
            
            else if( diff == 1) {
                // adv player
                
               playergpoutlet.text = "ADV"
               computergpoutlet.text = " - "
            }
            
            else if diff == 0 {
                // deuce
                
                playergpoutlet.text = "DEUCE"
                computergpoutlet.text = "DEUCE"
            }
            
            else if diff == -1 {
                // adv computer
                
                playergpoutlet.text = " - "
                computergpoutlet.text = "ADV"
            }
            
            else {
                //computer won
                
                // reset points
                statsManager.computerScore[2] = 0
                statsManager.playerScore[2] = 0
                
                // add 1 to computer games
                statsManager.computerScore[1] += 1
                
                // reset score text views
                playergpoutlet.text = scoreInfo[0]
                computergpoutlet.text = scoreInfo[0]
                
                // update computer games text view
                Cgames.text = String(statsManager.computerScore[1])
            }
        } else {
            // normal score update
            
            playergpoutlet.text = scoreInfo[points]
            computergpoutlet.text = scoreInfo[aiPoints]
            
        }
    }
    

}


