import Foundation

class Calculator {
    /// Performs addition of 2 numbers and reports if overflow occurs
    /// - Parameters:
    ///   - no1: first number
    ///   - no2: second number
    /// - Returns: result of addition
    func add(no1: Int, no2: Int) -> Int {
        let resultReport = no1.addingReportingOverflow(no2)
        if(resultReport.overflow) {
            // resultReport.overflow is true if overflow occurs during addition
            print("Integer overflow/out-of-bounds occured")
            exit(2)
        }
        return resultReport.partialValue
    }
    /// Performs subtraction of 2 numbers and reports if overflow occurs
    /// - Parameters:
    ///   - no1: first number
    ///   - no2: second number
    /// - Returns: result of subtraction
    func subtract(no1: Int, no2: Int) -> Int {
        let resultReport = no1.subtractingReportingOverflow(no2)
        if(resultReport.overflow) {
            // resultReport.overflow is true if overflow occurs during subtraction
            print("Integer overflow/out-of-bounds occured")
            exit(2)
        }
        return resultReport.partialValue
    }
    /// Performs multiplication of 2 numbers and reports if overflow occurs
    /// - Parameters:
    ///   - no1: first number
    ///   - no2: second number
    /// - Returns: result of multiplication
    func multiply(no1: Int, no2: Int) -> Int {
        let resultReport = no1.multipliedReportingOverflow(by: no2)
        if(resultReport.overflow) {
            // resultReport.overflow is true if overflow occurs during multiplication
            print("Integer overflow/out-of-bounds occured")
            exit(2)
        }
        return resultReport.partialValue
    }
    /// Performs division of 2 numbers and reports if overflow occurs or tries to divide by 0
    /// - Parameters:
    ///   - no1: first number to be divided
    ///   - no2: second number that is divided by
    /// - Returns: result of division
    func divide(no1: Int, no2: Int) -> Int {
        if(no2 == 0) {
            // exit if tries to divide by 0
            print("Cannot divide by 0")
            exit(3)
        }
        let resultReport = no1.dividedReportingOverflow(by: no2)
        if(resultReport.overflow) {
            // resultReport.overflow is true if overflow occurs during division
            print("Integer overflow/out-of-bounds occured")
            exit(2)
        }
        return resultReport.partialValue
    }
    /// Performs remainer operation of 2 numbers and reports if overflow occurs
    /// - Parameters:
    ///   - no1: first number to be divided
    ///   - no2: second number that is divided by
    /// - Returns: result of remainder operation
    func remain(no1: Int, no2: Int) -> Int {
        if(no2 == 0) {
            // exit if tries to divide by 0
            print("Cannot divide by 0")
            exit(3)
        }
        let resultReport = no1.remainderReportingOverflow(dividingBy: no2)
        if(resultReport.overflow) {
            // resultReport.overflow is true if overflow occurs during remainder operation
            print("Integer overflow/out-of-bounds occured")
            exit(2)
        }
        return resultReport.partialValue
    }
    
    /// Puts value into where the operator originally was and removes the 2 surrounding numbers
    /// - Parameters:
    ///   - value: value to be put in
    ///   - array: array which the value will be put in
    ///   - index: index of the operator where the value would be put in and the 2 surrounding numbers to be removed
    func putValueInArray(value: Int, array: inout [String], index:Int) {
        array[index] = String(value)
        array.remove(at: index+1)
        array.remove(at: index-1)
        
    }
    
    /// Performs algebraic calculations on the expression inputted and outputs the result
    /// - Parameter args: the array contains the expression, each item is either a number or operator
    /// - Returns: the result of the inputted expression
    func calculate(args: [String]) -> String {
        var items = args
        var phaseOne:Bool = false
        var phaseTwo:Bool = false
        
        var tempResult:Int = 0
        var signIndex:Int = 1
        if(items.count > 1){
            // checks to ensure there is more than 1 number/item in the inputted expression
            // if true, start the calculation process with multiplication (x), division (/) and remainder(%) from left to right
            phaseOne = true
        }
        
        // Phase 1 looks for and performs multiplication (x), division (/) and remainder(%) from left to right
        while phaseOne {
            if(items.count == 1){
                // if there is only 1 item left, the calculation is finished so break from the loop
                break
            }
            
            let leftNum:Int = Int(items[signIndex-1])! //the number to the left of the sign/operator
            let rightNum:Int = Int(items[signIndex+1])! //the number to the right of the sign/operator
            var itemsChanged:Bool = false
            
            switch(items[signIndex]) {
            case "x":
                tempResult = multiply(no1: leftNum, no2: rightNum)
                itemsChanged = true
            case "/":
                tempResult = divide(no1: leftNum, no2: rightNum)
                itemsChanged = true
            case "%":
                tempResult = remain(no1: leftNum, no2: rightNum)
                itemsChanged = true
            default:
                ()
            }
            if(itemsChanged) {
                // replace the sign with the result of that operator and the 2 numbers surrounding it
                putValueInArray(value: tempResult, array: &items, index: signIndex)
                signIndex = 1
            }
            else if(signIndex == items.count-2) {
                // phase 1 calculation ends if reaches the end of the expression with no items changed or operations/calculations handled
                phaseOne = false
            }
            else {
                // continue phase 1 with the next sign if not at the end of the expression and no calculations yet
                signIndex = signIndex + 2
            }
        }
        
        tempResult = 0
        signIndex = 1
        if(items.count > 1){
            // checks to ensure there is more than 1 number/item in the inputted expression
            // if true, continue the calculation process with addition (+) and subtraction (-) from left to right
            phaseTwo = true
        }
        
        // Phase 2 looks for and performs addition (+) and subtraction (-) from left to right
        while phaseTwo {
            if(items.count == 1){
                // if there is only 1 item left, the calculation is finished so break from the loop
                break
            }
            
            let leftNum:Int = Int(items[signIndex-1])! //the number to the left of the sign/operator
            let rightNum:Int = Int(items[signIndex+1])! //the number to the right of the sign/operator
            var itemsChanged:Bool = false
            
            switch(items[signIndex]) {
            case "+":
                tempResult = add(no1: leftNum, no2: rightNum)
                itemsChanged = true
            case "-":
                tempResult = subtract(no1: leftNum, no2: rightNum)
                itemsChanged = true
            default:
                ()
            }
            if(itemsChanged) {
                // replace the sign with the result of that operator and the 2 numbers surrounding it
                putValueInArray(value: tempResult, array: &items, index: signIndex)
                signIndex = 1
            }
            else if(signIndex == items.count-2) {
                // phase 2 calculation ends if reaches the end of the expression with no items changed or operations/calculations handled
                phaseTwo = false
            }
            else {
                // continue phase 2 with the next sign if not at the end of the expression and no calculations yet
                signIndex = signIndex + 2
            }
        }
        let result = String(Int(items[0])!)
        // the result will be the first item of the array as there will only be 1 item/number left
        return(result)
    }
}
