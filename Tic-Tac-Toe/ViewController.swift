//
//  ViewController.swift
//  Tic-Tac-Toe
//
//  Created by Brian Lim on 2/16/16.
//  Copyright © 2016 codebluapps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstImg: UIImageView!
    @IBOutlet weak var secondImg: UIImageView!
    @IBOutlet weak var thirdImg: UIImageView!
    @IBOutlet weak var fourthImg: UIImageView!
    @IBOutlet weak var fifthImg: UIImageView!
    @IBOutlet weak var sixthImg: UIImageView!
    @IBOutlet weak var seventhImg: UIImageView!
    @IBOutlet weak var eighthImg: UIImageView!
    @IBOutlet weak var ninthImg: UIImageView!
    
    @IBOutlet weak var player1Lbl: UILabel!
    @IBOutlet weak var player2Lbl: UILabel!
    @IBOutlet weak var playAgainBtn: RoundedEdgesButton!
    @IBOutlet weak var changeNameBtn: RoundedEdgesButton!
    @IBOutlet weak var winnerLbl: RoundedEdgesLabel!
    
    var player1Active: Bool = true
    var player2Active: Bool = false
    
    var player1Winner:Bool = false
    var player2Winner:Bool = false
    
    var gameRestarted:Bool = false
    var gameover:Bool = false
    var noWinner:Bool = false
    
    var timer:NSTimer!
    var activePlayerTimer:NSTimer!
    
    var passedName1: String!
    var passedName2: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timer = NSTimer.scheduledTimerWithTimeInterval(0.50, target: self, selector: Selector("checkBoard"), userInfo: nil, repeats: true)
        activePlayerTimer = NSTimer.scheduledTimerWithTimeInterval(0.10, target: self, selector: Selector("updateActivePlayerLbl"), userInfo: nil, repeats: true)
        player1Lbl.text = "\(passedName1)"
        player2Lbl.text = "\(passedName2)"
        player1Lbl.backgroundColor = UIColor.greenColor()
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: Selector("firstImgPressed:"))
        firstImg.addGestureRecognizer(tapGesture1)
        let tapGesture2 = UITapGestureRecognizer(target: self, action: Selector("secondImgPressed:"))
        secondImg.addGestureRecognizer(tapGesture2)
        let tapGesture3 = UITapGestureRecognizer(target: self, action: Selector("thirdImgPressed:"))
        thirdImg.addGestureRecognizer(tapGesture3)
        let tapGesture4 = UITapGestureRecognizer(target: self, action: Selector("fourthImgPressed:"))
        fourthImg.addGestureRecognizer(tapGesture4)
        let tapGesture5 = UITapGestureRecognizer(target: self, action: Selector("fifthImgPressed:"))
        fifthImg.addGestureRecognizer(tapGesture5)
        let tapGesture6 = UITapGestureRecognizer(target: self, action: Selector("sixthImgPressed:"))
        sixthImg.addGestureRecognizer(tapGesture6)
        let tapGesture7 = UITapGestureRecognizer(target: self, action: Selector("seventhImgPressed:"))
        seventhImg.addGestureRecognizer(tapGesture7)
        let tapGesture8 = UITapGestureRecognizer(target: self, action: Selector("eighthImgPressed:"))
        eighthImg.addGestureRecognizer(tapGesture8)
        let tapGesture9 = UITapGestureRecognizer(target: self, action: Selector("ninthImgPressed:"))
        ninthImg.addGestureRecognizer(tapGesture9)
        
        winnerLbl.clipsToBounds = true
        player1Lbl.clipsToBounds = true
        player2Lbl.clipsToBounds = true

    }
    
    override func viewDidAppear(animated: Bool) {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.50, target: self, selector: Selector("checkBoard"), userInfo: nil, repeats: true)

        if let player1Name = NSUserDefaults.standardUserDefaults().valueForKey("p1Name") {
            player1Lbl.text = "\(player1Name)"
        }
        if let player2Name = NSUserDefaults.standardUserDefaults().valueForKey("p2Name") {
            player2Lbl.text = "\(player2Name)"
        }
    }
    
    func updateActivePlayerLbl() {
        if player1Active == true {
            player1Lbl.backgroundColor = UIColor.greenColor()
            player2Lbl.backgroundColor = UIColor.whiteColor()
        } else {
            player1Lbl.backgroundColor = UIColor.whiteColor()
            player2Lbl.backgroundColor = UIColor.greenColor()
        }
    }
    
    func checkBoard() {
        firstHorizontalRow()
        secondHorizontalRow()
        thirdHorizontalRow()
        firstVerticalColumn()
        secondVerticalColumn()
        thirdVerticalColumn()
        leftToRightDiagnol()
        rightToLeftDiagnol()
        
        checkIfWinner()
        removeBgColor()

    }
    
    func removeBgColor() {
        
        if player1Winner == true || player2Winner == true {
            
            if player1Lbl.backgroundColor == UIColor.greenColor() {
                
                player1Lbl.backgroundColor = UIColor.whiteColor()
                
            } else if player2Lbl.backgroundColor == UIColor.greenColor() {
                
                player2Lbl.backgroundColor = UIColor.whiteColor()
            }
        }
        if player1Winner == false && player2Winner == false && gameover == true {
            player1Lbl.backgroundColor = UIColor.whiteColor()
            player2Lbl.backgroundColor = UIColor.whiteColor()
        }
        
    }
    
    @IBAction func playAgainBtnPressed(sender: AnyObject) {
        gameover = false
        playAgainBtn.alpha = 0.0
        changeNameBtn.alpha = 0.0
        winnerLbl.alpha = 0.0
        gameRestarted = true
        clearBoard()
        enableUserInteraction()
        player1Winner = false
        player2Winner = false
        
        if player1Active == true {
            player1Lbl.backgroundColor = UIColor.greenColor()
            player2Lbl.backgroundColor = UIColor.whiteColor()
        } else {
            player1Lbl.backgroundColor = UIColor.whiteColor()
            player2Lbl.backgroundColor = UIColor.greenColor()
        }
        
    }
    
    func disableUserInteraction() {
        firstImg.userInteractionEnabled = false
        secondImg.userInteractionEnabled = false
        thirdImg.userInteractionEnabled = false
        fourthImg.userInteractionEnabled = false
        fifthImg.userInteractionEnabled = false
        sixthImg.userInteractionEnabled = false
        seventhImg.userInteractionEnabled = false
        eighthImg.userInteractionEnabled = false
        ninthImg.userInteractionEnabled = false
    }
    
    func enableUserInteraction() {
        firstImg.userInteractionEnabled = true
        secondImg.userInteractionEnabled = true
        thirdImg.userInteractionEnabled = true
        fourthImg.userInteractionEnabled = true
        fifthImg.userInteractionEnabled = true
        sixthImg.userInteractionEnabled = true
        seventhImg.userInteractionEnabled = true
        eighthImg.userInteractionEnabled = true
        ninthImg.userInteractionEnabled = true
    }
    
    func clearBoard() {
        firstImg.image = nil
        secondImg.image = nil
        thirdImg.image = nil
        fourthImg.image = nil
        fifthImg.image = nil
        sixthImg.image = nil
        seventhImg.image = nil
        eighthImg.image = nil
        ninthImg.image = nil

    }
    
    func checkIfWinner() {
        if player1Winner == false && player2Winner == false && gameover == true {
            playAgainBtn.alpha = 1.0
            changeNameBtn.alpha = 1.0
            removeBgColor()
            disableUserInteraction()
            animateWinnerLbl()
            winnerLbl.text = "It's a Tie!"
        }
        
        if firstImg.image !== nil && secondImg.image !== nil && thirdImg.image !== nil && fourthImg.image !== nil && fifthImg.image !== nil && sixthImg.image !== nil && seventhImg.image !== nil && eighthImg.image !== nil && ninthImg.image !== nil {
            
            if winnerLbl.alpha == 0.0 {
                gameover = true
                
            }
        }
    }
    
    func animateWinnerLbl() {
        if winnerLbl.alpha == 0.0 {
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                self.winnerLbl.alpha = 1.0
            })
        }
    }
    
    // TODO:
    // FIGURE OUT HOW TO DISPLAY THAT ITS A TIE IF THERE IS NO POSSIBLE OUTCOMES OR THERE ARE NO MORE SPACES
    
    
    func firstHorizontalRow() {
        if firstImg.image == UIImage(named: "LetterX") {
            if secondImg.image == UIImage(named: "LetterX") {
                if thirdImg.image == UIImage(named: "LetterX") {
                    
                    player1Winner = true
                    timer.invalidate()
                    winnerLbl.text = "The Winner is: \(player1Lbl.text!)"
                    animateWinnerLbl()
                    disableUserInteraction()
                    player1Active = false
                    player2Active = true
                    gameRestarted = false
                    gameover = true
                    playAgainBtn.alpha = 1.0
                    changeNameBtn.alpha = 1.0
                    
                }
            }
        } else {
            if firstImg.image == UIImage(named: "LetterO") {
                if secondImg.image == UIImage(named: "LetterO") {
                    if thirdImg.image == UIImage(named: "LetterO") {
                        
                        player2Winner = true
                        timer.invalidate()
                        winnerLbl.text = "The Winner is: \(player2Lbl.text!)"
                        animateWinnerLbl()
                        disableUserInteraction()
                        player2Active = false
                        player1Active = true
                        gameRestarted = false
                        gameover = true
                        playAgainBtn.alpha = 1.0
                        changeNameBtn.alpha = 1.0


                    }
                }
            }
        }
    }
    
    func secondHorizontalRow() {
        if fourthImg.image == UIImage(named: "LetterX") {
            if fifthImg.image == UIImage(named: "LetterX") {
                if sixthImg.image == UIImage(named: "LetterX") {
                    
                    player1Winner = true
                    timer.invalidate()
                    winnerLbl.text = "The Winner is: \(player1Lbl.text!)"
                    animateWinnerLbl()
                    disableUserInteraction()
                    player1Active = false
                    player2Active = true
                    gameRestarted = false
                    gameover = true
                    playAgainBtn.alpha = 1.0
                    changeNameBtn.alpha = 1.0



                }
            }
        } else {
            if fourthImg.image == UIImage(named: "LetterO") {
                if fifthImg.image == UIImage(named: "LetterO") {
                    if sixthImg.image == UIImage(named: "LetterO") {
                        
                        player2Winner = true
                        timer.invalidate()
                        winnerLbl.text = "The Winner is: \(player2Lbl.text!)"
                        animateWinnerLbl()
                        disableUserInteraction()
                        player2Active = false
                        player1Active = true
                        gameRestarted = false
                        gameover = true
                        playAgainBtn.alpha = 1.0
                        changeNameBtn.alpha = 1.0



                    }
                }
            }
        }
    }
    
    func thirdHorizontalRow() {
        if seventhImg.image == UIImage(named: "LetterX") {
            if eighthImg.image == UIImage(named: "LetterX") {
                if ninthImg.image == UIImage(named: "LetterX") {
                    
                    player1Winner = true
                    timer.invalidate()
                    winnerLbl.text = "The Winner is: \(player1Lbl.text!)"
                    animateWinnerLbl()
                    disableUserInteraction()
                    player1Active = false
                    player2Active = true
                    gameRestarted = false
                    gameover = true
                    playAgainBtn.alpha = 1.0
                    changeNameBtn.alpha = 1.0



                }
            }
        } else {
            if seventhImg.image == UIImage(named: "LetterO") {
                if eighthImg.image == UIImage(named: "LetterO") {
                    if ninthImg.image == UIImage(named: "LetterO") {
                        
                        player2Winner = true
                        timer.invalidate()
                        winnerLbl.text = "The Winner is: \(player2Lbl.text!)"
                        animateWinnerLbl()
                        disableUserInteraction()
                        player2Active = false
                        player1Active = true
                        gameRestarted = false
                        gameover = true
                        playAgainBtn.alpha = 1.0
                        changeNameBtn.alpha = 1.0



                    }
                }
            }
        }
    }
    
    func firstVerticalColumn() {
        if firstImg.image == UIImage(named: "LetterX") {
            if fourthImg.image == UIImage(named: "LetterX") {
                if seventhImg.image == UIImage(named: "LetterX") {
                    
                    player1Winner = true
                    timer.invalidate()
                    winnerLbl.text = "The Winner is: \(player1Lbl.text!)"
                    animateWinnerLbl()
                    disableUserInteraction()
                    player1Active = false
                    player2Active = true
                    gameRestarted = false
                    gameover = true
                    playAgainBtn.alpha = 1.0
                    changeNameBtn.alpha = 1.0


                }
            }
        } else {
            if firstImg.image == UIImage(named: "LetterO") {
                if fourthImg.image == UIImage(named: "LetterO") {
                    if seventhImg.image == UIImage(named: "LetterO") {
                        
                        player2Winner = true
                        timer.invalidate()
                        winnerLbl.text = "The Winner is: \(player2Lbl.text!)"
                        animateWinnerLbl()
                        disableUserInteraction()
                        player2Active = false
                        player1Active = true
                        gameRestarted = false
                        gameover = true
                        playAgainBtn.alpha = 1.0
                        changeNameBtn.alpha = 1.0


                    }
                }
            }
        }
    }
    
    func secondVerticalColumn() {
        if secondImg.image == UIImage(named: "LetterX") {
            if fifthImg.image == UIImage(named: "LetterX") {
                if eighthImg.image == UIImage(named: "LetterX") {
                    
                    player1Winner = true
                    timer.invalidate()
                    winnerLbl.text = "The Winner is: \(player1Lbl.text!)"
                    animateWinnerLbl()
                    disableUserInteraction()
                    player1Active = false
                    player2Active = true
                    gameRestarted = false
                    gameover = true
                    playAgainBtn.alpha = 1.0
                    changeNameBtn.alpha = 1.0


                }
            }
        } else {
            if secondImg.image == UIImage(named: "LetterO") {
                if fifthImg.image == UIImage(named: "LetterO") {
                    if eighthImg.image == UIImage(named: "LetterO") {
                        
                        player2Winner = true
                        timer.invalidate()
                        winnerLbl.text = "The Winner is: \(player2Lbl.text!)"
                        animateWinnerLbl()
                        disableUserInteraction()
                        player2Active = false
                        player1Active = true
                        gameRestarted = false
                        gameover = true
                        playAgainBtn.alpha = 1.0
                        changeNameBtn.alpha = 1.0


                    }
                }
            }
        }
    }
    
    func thirdVerticalColumn() {
        if thirdImg.image == UIImage(named: "LetterX") {
            if sixthImg.image == UIImage(named: "LetterX") {
                if ninthImg.image == UIImage(named: "LetterX") {
                    
                    player1Winner = true
                    timer.invalidate()
                    winnerLbl.text = "The Winner is: \(player1Lbl.text!)"
                    animateWinnerLbl()
                    disableUserInteraction()
                    player1Active = false
                    player2Active = true
                    gameRestarted = false
                    gameover = true
                    playAgainBtn.alpha = 1.0
                    changeNameBtn.alpha = 1.0


                }
            }
        } else {
            if thirdImg.image == UIImage(named: "LetterO") {
                if sixthImg.image == UIImage(named: "LetterO") {
                    if ninthImg.image == UIImage(named: "LetterO") {
                        
                        player2Winner = true
                        timer.invalidate()
                        winnerLbl.text = "The Winner is: \(player2Lbl.text!)"
                        animateWinnerLbl()
                        disableUserInteraction()
                        player2Active = false
                        player1Active = true
                        gameRestarted = false
                        gameover = true
                        playAgainBtn.alpha = 1.0
                        changeNameBtn.alpha = 1.0


                    }
                }
            }
        }
    }
    
    func leftToRightDiagnol() {
        if firstImg.image == UIImage(named: "LetterX") {
            if fifthImg.image == UIImage(named: "LetterX") {
                if ninthImg.image == UIImage(named: "LetterX") {
                    
                    player1Winner = true
                    timer.invalidate()
                    winnerLbl.text = "The Winner is: \(player1Lbl.text!)"
                    animateWinnerLbl()
                    disableUserInteraction()
                    player1Active = false
                    player2Active = true
                    gameRestarted = false
                    gameover = true
                    playAgainBtn.alpha = 1.0
                    changeNameBtn.alpha = 1.0


                }
            }
        } else {
            if firstImg.image == UIImage(named: "LetterO") {
                if fifthImg.image == UIImage(named: "LetterO") {
                    if ninthImg.image == UIImage(named: "LetterO") {
                        
                        player2Winner = true
                        timer.invalidate()
                        winnerLbl.text = "The Winner is: \(player2Lbl.text!)"
                        animateWinnerLbl()
                        disableUserInteraction()
                        player2Active = false
                        player1Active = true
                        gameRestarted = false
                        gameover = true
                        playAgainBtn.alpha = 1.0
                        changeNameBtn.alpha = 1.0


                    }
                }
            }
        }
    }
    
    func rightToLeftDiagnol() {
        if thirdImg.image == UIImage(named: "LetterX") {
            if fifthImg.image == UIImage(named: "LetterX") {
                if seventhImg.image == UIImage(named: "LetterX") {
                    
                    player1Winner = true
                    timer.invalidate()
                    winnerLbl.text = "The Winner is: \(player1Lbl.text!)"
                    animateWinnerLbl()
                    disableUserInteraction()
                    player1Active = false
                    player2Active = true
                    gameRestarted = false
                    gameover = true
                    playAgainBtn.alpha = 1.0
                    changeNameBtn.alpha = 1.0


                }
            }
        } else {
            if thirdImg.image == UIImage(named: "LetterO") {
                if fifthImg.image == UIImage(named: "LetterO") {
                    if seventhImg.image == UIImage(named: "LetterO") {
                        
                        player2Winner = true
                        timer.invalidate()
                        winnerLbl.text = "The Winner is: \(player2Lbl.text!)"
                        animateWinnerLbl()
                        disableUserInteraction()
                        player2Active = false
                        player1Active = true
                        gameRestarted = false
                        gameover = true
                        playAgainBtn.alpha = 1.0
                        changeNameBtn.alpha = 1.0


                    }
                }
            }
        }
    }
    
    func firstImgPressed(tap: UITapGestureRecognizer) {
        // Checking if its player 1's turn
        if player1Active == true {
            
            // If so, check if there is an image set already
            if firstImg.image == nil {
                
                // if not, set the image to X since its player1 playing
                firstImg.image = UIImage(named: "LetterX")
                // Then set player2active = true (Meaning its player 2's turn)
                player2Active = true
                player1Active = false
                // Disable the interaction with this button
                firstImg.userInteractionEnabled = false
            }
            
        } else {
            
            // It's player 2's turn
            // Checking if there is an image set already
            if firstImg.image == nil {
                
                // If not, set the image to the O since its player2 playing
                firstImg.image = UIImage(named: "LetterO")
                // Then set player1active = true (Meaning its player 1's turn)
                player1Active = true
                player2Active = false
                // Diable the interaction with this button
                firstImg.userInteractionEnabled = false
            }
        }
    }
    
    func secondImgPressed(tap: UITapGestureRecognizer) {
        
        // Checking if its player 1's turn
        if player1Active == true {
            
            // If so, check if there is an image set already
            if secondImg.image == nil {
                
                // If not, set the image to X since its player1 playing
                secondImg.image = UIImage(named: "LetterX")
                // Then se player2active = true (Meaning its player2's turn)
                player2Active = true
                player1Active = false
                // Disable the interacion with this button
                secondImg.userInteractionEnabled = false
            }
            
        } else {

            if secondImg.image == nil {
                
                secondImg.image = UIImage(named: "LetterO")

                player1Active = true
                player2Active = false
                secondImg.userInteractionEnabled = false
            }
        }
        
    }
    
    func thirdImgPressed(tap: UITapGestureRecognizer) {

        if player1Active == true {
            
            if thirdImg.image == nil {
                
                thirdImg.image = UIImage(named: "LetterX")
                player2Active = true
                player1Active = false
                thirdImg.userInteractionEnabled = false
            }
            
        } else {
            
            if thirdImg.image == nil {
                
                thirdImg.image = UIImage(named: "LetterO")
                player1Active = true
                player2Active = false
                thirdImg.userInteractionEnabled = false
            }
        }
    }
    
    func fourthImgPressed(tap: UITapGestureRecognizer) {

        if player1Active == true {
            
            if fourthImg.image == nil {
                
                fourthImg.image = UIImage(named: "LetterX")
                player2Active = true
                player1Active = false
                fourthImg.userInteractionEnabled = false
            }
            
        } else {
            
            if fourthImg.image == nil {
                
                fourthImg.image = UIImage(named: "LetterO")
                player1Active = true
                player2Active = false
                fourthImg.userInteractionEnabled = false
            }
        }
    }
    
    func fifthImgPressed(tap: UITapGestureRecognizer) {

        if player1Active == true {

            if fifthImg.image == nil {
                
                fifthImg.image = UIImage(named: "LetterX")
                player2Active = true
                player1Active = false
                fifthImg.userInteractionEnabled = false
            }
            
        } else {
        
            if fifthImg.image == nil {
                
                fifthImg.image = UIImage(named: "LetterO")
                player1Active = true
                player2Active = false
                fifthImg.userInteractionEnabled = false
            }
        }
    }
    
    func sixthImgPressed(tap: UITapGestureRecognizer) {

        if player1Active == true {
            
            if sixthImg.image == nil {
                
                sixthImg.image = UIImage(named: "LetterX")
                player2Active = true
                player1Active = false
                sixthImg.userInteractionEnabled = false
            }
            
        } else {
            
            if sixthImg.image == nil {
                
                sixthImg.image = UIImage(named: "LetterO")
                player1Active = true
                player2Active = false
                sixthImg.userInteractionEnabled = false
            }
        }
    }
    
    func seventhImgPressed(tap: UITapGestureRecognizer) {
        if player1Active == true {
            
            if seventhImg.image == nil {
                
                seventhImg.image = UIImage(named: "LetterX")
                player2Active = true
                player1Active = false
                seventhImg.userInteractionEnabled = false
            }
            
        } else {
            
            if seventhImg.image == nil {
                
                seventhImg.image = UIImage(named: "LetterO")
                player1Active = true
                player2Active = false
                seventhImg.userInteractionEnabled = false
            }
        }
    }
    
    func eighthImgPressed(tap: UITapGestureRecognizer) {
        if player1Active == true {
            
            if eighthImg.image == nil {
                
                eighthImg.image = UIImage(named: "LetterX")
                player2Active = true
                player1Active = false
                eighthImg.userInteractionEnabled = false
            }
            
        } else {
            
            if eighthImg.image == nil {
                
                eighthImg.image = UIImage(named: "LetterO")
                player1Active = true
                player2Active = false
                eighthImg.userInteractionEnabled = false
            }
        }
        
    }
    
    func ninthImgPressed(tap: UITapGestureRecognizer) {
        if player1Active == true {
            
            if ninthImg.image == nil {
                
                ninthImg.image = UIImage(named: "LetterX")
                player2Active = true
                player1Active = false
                ninthImg.userInteractionEnabled = false
            }
            
        } else {
            
            if ninthImg.image == nil {
                
                ninthImg.image = UIImage(named: "LetterO")
                player1Active = true
                player2Active = false
                ninthImg.userInteractionEnabled = false
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

