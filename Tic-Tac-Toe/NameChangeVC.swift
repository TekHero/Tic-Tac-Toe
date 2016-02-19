//
//  NameChangeVC.swift
//  Tic-Tac-Toe
//
//  Created by Brian Lim on 2/17/16.
//  Copyright © 2016 codebluapps. All rights reserved.
//

import UIKit

class NameChangeVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var p1TextField: UITextField!
    @IBOutlet weak var p2TextField: UITextField!
    @IBOutlet weak var p1TitleLbl: RoundedEdgesLabel!
    @IBOutlet weak var p2TitleLbl: RoundedEdgesLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        p1TextField.delegate = self
        p2TextField.delegate = self
        
        p1TitleLbl.clipsToBounds = true
        p2TitleLbl.clipsToBounds = true
    }
    
    override func viewDidAppear(animated: Bool) {
        if let p1Name = NSUserDefaults.standardUserDefaults().valueForKey("p1Name") {
            p1TextField.text = "\(p1Name)"
        }
        if let p2Name = NSUserDefaults.standardUserDefaults().valueForKey("p2Name") {
            p2TextField.text = "\(p2Name)"
        }
    }

    @IBAction func playBtnPressed(sender: AnyObject) {
        performSegueWithIdentifier("gameVC", sender: nil)
        NSUserDefaults.standardUserDefaults().setValue(p1TextField.text, forKey: "p1Name")
        NSUserDefaults.standardUserDefaults().setValue(p2TextField.text, forKey: "p2Name")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "gameVC" {
            
            let gameVC = segue.destinationViewController as! ViewController
            gameVC.passedName1 = p1TextField.text
            gameVC.passedName2 = p2TextField.text
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        p1TextField.resignFirstResponder()
        p2TextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        p1TextField.resignFirstResponder()
        p2TextField.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
