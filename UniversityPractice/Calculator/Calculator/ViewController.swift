//
//  ViewController.swift
//  Calculator
//
//  Created by BrusovaPolina on 12/02/22.
//  Copyright © 2022 BrusovaPolina. All rights reserved.
//  Modified by BrusovaPolina on 16/02/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var operationLabel: UILabel!
    
    let resString = NSLocalizedString("STRING_DATA", comment: "the string for result")
    @IBOutlet weak var textLabel: UILabel!
    
    var numberOnScreen: String?
    var numberOnSecondScreen: String?
    var previousSign: String = "+"
    var newCalcuator: Bool? = true
    var previousButton: String = ""
    var result: Double = 0
    
    @IBAction func numberTap(_ sender: UIButton) {

        if previousButton == "+" || previousButton == "-" || previousButton == "×" || previousButton == "÷" || previousButton == "%" {
            newCalcuator = false
        }
        
        if newCalcuator! {
            self.clearScreen()
        }
        
        newCalcuator = false
        
        numberOnScreen = resultLabel.text
        if sender.currentTitle == "." {
            if resultLabel.text!.contains(".") {
                return
            }
            if numberOnScreen == "0" {
                resultLabel.text = numberOnScreen! + sender.currentTitle!
                return
            }
        }
        if numberOnScreen == "0" {
            numberOnScreen = ""
        }
        resultLabel.text = numberOnScreen! + sender.currentTitle!
        
        previousButton = sender.currentTitle!
    }
    
    @IBAction func operatorTap(_ sender: UIButton) {
        
        if (previousButton == "+" || previousButton == "-" || previousButton == "×" || previousButton == "÷" || previousButton == "%") && sender.currentTitle != "=" {
            operationLabel.text = "\(formatNumber(result)) \(sender.currentTitle!) "
            previousButton = sender.currentTitle!
            previousSign = previousButton
            return
        }
        
        if sender.currentTitle! == "=" {
            if operationLabel.text! == "" || previousButton == "="{
                return
            }
        }
        
        numberOnSecondScreen = operationLabel.text!
        
        if sender.currentTitle != "=" {
            if numberOnSecondScreen == "" {
                numberOnSecondScreen = resultLabel.text!
                operationLabel.text = numberOnSecondScreen! + sender.currentTitle!
            } else {
                numberOnSecondScreen = operationLabel.text!
                operationLabel.text = numberOnSecondScreen! + resultLabel.text! + sender.currentTitle!
            }
        } else {
            if numberOnSecondScreen == "" {
                numberOnSecondScreen = resultLabel.text!
                operationLabel.text = numberOnSecondScreen!
            } else {
                numberOnSecondScreen = operationLabel.text!
                operationLabel.text = numberOnSecondScreen! + resultLabel.text!
            }
        }
        
        switch previousSign {
        case "+":
            result += Double(resultLabel.text!)!
        case "-":
            result -= Double(resultLabel.text!)!
        case "×":
            result *= Double(resultLabel.text!)!
        case "÷":
            result /= Double(resultLabel.text!)!
        case "%":
            result = result.truncatingRemainder(dividingBy: Double(resultLabel.text!)!)
        default:
            print("err")
        }
        
        
        
        if sender.currentTitle! == "=" {
            operationLabel.text = "\(operationLabel.text!) "
            
            if formatNumber(result) == "inf" || formatNumber(result) == "nan" {
                resultLabel.text = "Error"
            } else {
                resultLabel.text = formatNumber(result)
            }
            self.resetCalculator()
        } else {
            operationLabel.text = "\(formatNumber(result)) \(sender.currentTitle!) "
            previousSign = sender.currentTitle!

            resultLabel.text = "0"
        }
        
        
        previousButton = sender.currentTitle!
        
        
    }
    
    
    @IBAction func otherButtonTap(_ sender: UIButton) {
        if sender.currentTitle == "C" {
            self.clearScreen()
        } else if sender.currentTitle == "+/-" {
            var tempNum = Double(resultLabel.text!)!
            tempNum = -tempNum
            resultLabel.text = self.formatNumber(tempNum)
        }
        
        previousButton = sender.currentTitle!
    }
    
    func clearScreen() -> Void {
        operationLabel.text = ""
        resultLabel.text = "0"
        result = 0
        previousSign = "+"
        newCalcuator = true
    }
    
    func resetCalculator() -> Void {
        previousSign = "+"
        newCalcuator = true
        result = 0
    }
    
    func formatNumber(_ number: Double) -> String{
        return String(format: "%g", number)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        textLabel.text = String.localizedStringWithFormat(resString)
        super.viewDidLoad()
    }
}

@IBDesignable class customButton: UIButton {
    @IBInspectable
    public var cornerRadius: CGFloat = 0.0 {
        didSet {
           self.layer.cornerRadius = self.cornerRadius
        }
    }
}
