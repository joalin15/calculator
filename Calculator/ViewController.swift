//
//  ViewController.swift
//  Swift Test
//
//  Created by Joann Lin on 4/2/17.
//  Copyright © 2017 Joann Lin. All rights reserved.
//

import UIKit // used for external UI stuff
//import Foundation // used for internal stuff


// inherits from UIViewController - Swift supports single inheritance
class ViewController: UIViewController {
    
    //instance variables (AKA properties)
    
    // optional UI label
    // ! makes it so that it is always unwrapped when used
    //@IBOutlet weak var display: UILabel?
    @IBOutlet weak var display: UILabel!

    var userIsTyping: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        display.adjustsFontSizeToFitWidth = true
        display.minimumScaleFactor = 0.5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // outlet -> creates instance variable
    // action -> creates function
    @IBAction func touchDigit(_ sender: UIButton) {
//        let digit = sender.currentTitle!
//        if userIsTyping {
//            let textCurrentlyInDisplay = display.text!
//            display.text = textCurrentlyInDisplay + digit
//        } else {
//            display.text = digit
//            userIsTyping = true;
//        }
    }
    
    //computed property
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()

    @IBAction func performOperation(_ sender: UIButton) {
        let mathematicalSymbol = sender.currentTitle
        if (mathematicalSymbol != nil){
            brain.performOperation(mathematicalSymbol!)
        }
        if let result = brain.result {
            let resultString = String(format: "%g", result);
            if userIsTyping {
                let textCurrentlyInDisplay = display.text!
                display.text = textCurrentlyInDisplay + resultString
            } else {
                display.text = resultString;
                userIsTyping = true;
            }
        } else {
            if userIsTyping {
                let textCurrentlyInDisplay = display.text!
                display.text = textCurrentlyInDisplay + mathematicalSymbol!
            } else {
                display.text = " ";
            }
        }
    }
    
    @IBAction func finishedTyping(_ sender: Any) {
        userIsTyping = false
    }
}

