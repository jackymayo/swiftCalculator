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
    var userIsPressingButton = false
   
    
    @IBOutlet weak var calculatorDisplay: UILabel!

  
    @IBAction func calculatorDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        //used for inital debugging print("\(digit)")
        if userIsPressingButton {
            calculatorDisplay.text = calculatorDisplay.text! + digit
        }
        else{
            calculatorDisplay.text = digit
            userIsPressingButton = true
        }
    
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
        case "x²": performOperation(){$0 * $0}
            default: break
        }
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
    
    @IBAction func clearButton() {
        operandStack.removeAll()
        calculatorDisplay.text = "0"
        userIsPressingButton = false;
        print("operandStack = \(operandStack)")
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
        //resets the display
        userIsPressingButton = false
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
