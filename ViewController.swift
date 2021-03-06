//
//  ViewController.swift
//  Calender
//
//  Created by Jie on 16/9/2.
//  Copyright © 2016年 com.HuXiaoQian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleOfTypingANumber:Bool = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text!+digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        operandStack.append(displayValue)
        print("\(operandStack)")
        currentOperation = sender.currentTitle!
        userIsInTheMiddleOfTypingANumber = false
    }
    
    func performOpeatrion(operation:(Double,Double)->Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
    }
    private func performOpeatrion(operation:(Double) -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }

    var operandStack = Array<Double>()
    
    @IBAction func appendDot(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text!+"."
        } else {
            display.text = "0"+"."
        }
        userIsInTheMiddleOfTypingANumber = true
    }
    
    @IBAction func appendPi(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            display.text = "\(NSDecimalNumber(string:display.text!).doubleValue * M_PI)"
        } else {
            display.text = "\(M_PI)"
        }
        userIsInTheMiddleOfTypingANumber = true
    }
    
    @IBAction func enter() {
        if userIsInTheMiddleOfTypingANumber {
            operandStack.append(displayValue)
            print("\(operandStack)")
        }
        let operation = currentOperation
        currentOperation = " "
        switch operation {
        case "+":performOpeatrion(){$0 + $1}
        case "−":performOpeatrion(){$1 - $0}
        case "×":performOpeatrion(){$0 * $1}
        case "÷":performOpeatrion(){$1 / $0}
        case "√":performOpeatrion(){sqrt($0)}
        default:
            break
        }
        userIsInTheMiddleOfTypingANumber = false
    }
    
    

    var currentOperation:String = " "
    
    var displayValue:Double {
        get {
            return NSDecimalNumber(string:display.text!).doubleValue
        }
        set {
            display.text = "\(NSDecimalNumber(string:"\(newValue)"))"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    @IBAction func memoryClear() {
        operandStack.removeAll()
    }
    @IBAction func clear() {
        memoryClear()
        currentOperation = " "
        displayValue = 0
        display.text = "0"
    }
}

