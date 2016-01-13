//
//  ViewController.swift
//  swiftCalculator
//
//  Created by Jacky Moon on 2016-01-11.
//  All credits goes to Paul Hegarty's demo used as a reference
//  Copyright © 2016 Jacky Moon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var operandStack = Array<Double>()
    //false sets display to be original value 
    //true appends the digit
    var userIsPressingButton = false
    //determines the proper usage for the UILabel input history

    
    //count the amount of times decimal has been used
   
    
    @IBOutlet weak var input: UILabel!
    @IBOutlet weak var calculatorDisplay: UILabel!
    
    func appendHistory(sender: String){
        input.text = input.text! + " " + sender
    }

    @IBAction func calculatorDigit(sender: UIButton) {
        let digit = sender.currentTitle!
            if userIsPressingButton{
                //if decimal found and digit used then terminate else keep going
                if !(calculatorDisplay.text!.rangeOfString(".") != nil && digit == "."){
                    calculatorDisplay.text = calculatorDisplay.text! + digit
                }
            }
            else{
                calculatorDisplay.text = digit
                userIsPressingButton = true
            }
            appendHistory("\(digit)")
    }
    
    @IBAction func operatorType(sender: UIButton) {
        let operatorValue = sender.currentTitle!
        
        switch operatorValue {
            //last operation could go outside
        case "×": performOperation(){$0 * $1}
        case "÷": performOperation(){$1 / $0}
        case "+": performOperation(){$0 + $1}
        case "−": performOperation(){$1 - $0}
        case "√": performOperation(){sqrt($0)}
        case "cos": performOperation(){cos($0)}
        case "sin": performOperation(){sin($0)}
        case "π": constantOperation(M_PI)
        default: break
        }
            appendHistory("\(operatorValue) =")
    }
    
    @nonobjc func performOperation(operation: (Double,Double) -> Double ) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enterButton()
        }
    }
    
    @nonobjc func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enterButton()
        }
    }
    
    //function used for constants
    func constantOperation(someConstant: Double){
        if userIsPressingButton {
            enterButton()
        }
        displayValue = someConstant
        enterButton()
    }
    
    @IBAction func clearButton() {
        operandStack.removeAll()
        calculatorDisplay.text = "0"
        userIsPressingButton = false;
        print("operandStack = \(operandStack)")
        appendHistory("C")
    }
  
    var displayValue : Double{
        get {
            return NSNumberFormatter().numberFromString(calculatorDisplay.text!)!.doubleValue
        }
        set {
            calculatorDisplay.text = "\(newValue)"
            userIsPressingButton = false
        }
    }
    @IBAction func enterButton() {
        //resets the display and decimal count
        userIsPressingButton = false
        
        //append the value to stack
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
        
    }
    
    
    @IBAction func historyEnter() {
        appendHistory("⏎")
    }

    


}
