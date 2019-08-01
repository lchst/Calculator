import Foundation

class Calculator {
    
// Constants and variables
    
    var number = ""
    var previousNumber = ""
    var operation = Operation.empty
    let viewController: ViewController
    
// Initializers and functions
    
    init(viewController: ViewController) {
        self.viewController = viewController
    }
    
    func receiveDigit(digit: Int) {
        if number.count < 8 {
            number += "\(digit)"
            viewController.displayNumber(number: number)
        }
    }
    
    func receiveComma() {
        if (number.count < 8) && (number.contains(".") == false) {
            number += "."
            viewController.displayNumber(number: number)
        }
    }
    
    func deleteNumber() {
        number = ""
        previousNumber = ""
        viewController.displayNumber(number: "0")
        self.operation = .empty
    }
    
    func doAddition() {
        doOperation(operation: .addition)
    }
    
    func doSubstraction() {
        doOperation(operation: .substraction)
    }
    
    func doMultiplication() {
        doOperation(operation: .multiplication)
    }
    
    func doDivision() {
        doOperation(operation: .division)
    }
    
    func calculatePercentage() {
        self.operation = .percentage
        doOperation(operation: .percentage)
    }
    
    func calculate() {
        if (previousNumber != "") && (number != "") {
            switch operation {
            case .addition: number = "\(Double(previousNumber)! + Double(number)!)"
            case .substraction: number = "\(Double(previousNumber)! - Double(number)!)"
            case .multiplication: number = "\(Double(previousNumber)! * Double(number)!)"
            case .division:
                if Int(number) != 0 {
                    number = "\(Double(previousNumber)! / Double(number)!)"
                } else {
                    viewController.displayNumber(number: "Error")
                    return
                }
            case .percentage: number = "\(Double(previousNumber)! * Double(number)! / 100)"
            case .empty: return
            }
        }
        
        if (((Double(number)! * 10.0).truncatingRemainder(dividingBy: 10.0)) == 0) {
            if (number.contains("-")) && (number.count >= 4) {
                number.removeLast(2)
            } else if (number.contains("-") != true) && (number.count >= 3) {
                number.removeLast(2)
            } else {
                print(number)
            }
        }
        
        print(String(format: "%g", Double(number)!))
            
        viewController.displayNumber(number: String(format: "%g", Double(number)!))
        previousNumber = ""
    }
    
    func doOperation(operation: Operation) {
        if (number != "") && (previousNumber == "") {
            previousNumber = number
            number = ""
            self.operation = operation
        } else if (number != "") && (previousNumber != "") {
            calculate()
            viewController.displayNumber(number: number)
            previousNumber = number
            number = ""
            self.operation = operation
        } else {
            number = ""
            self.operation = operation
        }
    }
    
// Enumeration
    
    enum Operation {
        case empty
        case addition
        case substraction
        case multiplication
        case division
        case percentage
    }
}

