import Foundation

class Calculator {
    /// Performs addition of 2 numbers
    /// - Parameters:
    ///   - no1: first number
    ///   - no2: second number
    /// - Returns: result of addition
    func add(no1: Int, no2: Int) -> Int {
        return no1 + no2
    }
    /// Performs subtraction of 2 numbers
    /// - Parameters:
    ///   - no1: first number
    ///   - no2: second number
    /// - Returns: result of subtraction
    func subtract(no1: Int, no2: Int) -> Int {
        return no1 - no2
    }
    /// Performs multiplication of 2 numbers
    /// - Parameters:
    ///   - no1: first number
    ///   - no2: second number
    /// - Returns: result of multiplication
    func multiply(no1: Int, no2: Int) -> Int {
        return no1 * no2
    }
    /// Performs division of 2 numbers
    /// - Parameters:
    ///   - no1: first number to be divided
    ///   - no2: second number that is divided by
    /// - Returns: result of division
    func divide(no1: Int, no2: Int) -> Int {
        return no1 / no2
    }
    /// Performs remainer operation of 2 numbers
    /// - Parameters:
    ///   - no1: first number to be divided
    ///   - no2: second number that is divided by
    /// - Returns: result of remainder operation
    func remain(no1: Int, no2: Int) -> Int {
        return no1 % no2
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
    
    func calculate(args: [String]) -> String {
        var items = args
        var phaseOne:Bool = false
        var phaseTwo:Bool = false
        
        var tempResult:Int = 0
        var signIndex:Int = 1
        if(items.count > 1){
            phaseOne = true
        }
        
        // Phase 1 looks for and performs multiplication (x), division (/) and remainder(%) from left to right
        while phaseOne {
            if(items.count == 1){
                break
            }
            
            let no1:Int = Int(items[signIndex-1])!
            let no2:Int = Int(items[signIndex+1])!
            var itemsChanged:Bool = false
            
            switch(items[signIndex]) {
            case "x":
                tempResult = multiply(no1: no1, no2: no2)
                itemsChanged = true
            case "/":
                tempResult = divide(no1: no1, no2: no2)
                itemsChanged = true
            case "%":
                tempResult = remain(no1: no1, no2: no2)
                itemsChanged = true
            default:
                ()
            }
            if(itemsChanged) {
                putValueInArray(value: tempResult, array: &items, index: signIndex)
                signIndex = 1
            }
            else if(signIndex == items.count-2) {
                phaseOne = false
            }
            else {
                signIndex = signIndex + 2
            }
        }
        
        tempResult = 0
        signIndex = 1
        if(items.count > 1){
            phaseTwo = true
        }
        
        // Phase 2 looks for and performs addition (+) and subtraction (-) from left to right
        while phaseTwo {
            if(items.count == 1){
                break
            }
            
            let no1:Int = Int(items[signIndex-1])!
            let no2:Int = Int(items[signIndex+1])!
            var itemsChanged:Bool = false
            
            switch(items[signIndex]) {
            case "+":
                tempResult = add(no1: no1, no2: no2)
                itemsChanged = true
            case "-":
                tempResult = subtract(no1: no1, no2: no2)
                itemsChanged = true
            default:
                ()
            }
            if(itemsChanged) {
                putValueInArray(value: tempResult, array: &items, index: signIndex)
                signIndex = 1
            }
            else if(signIndex == items.count-2) {
                phaseTwo = false
            }
            else {
                signIndex = signIndex + 2
            }
        }
        let result = String(Int(items[0])!)
        return(result)
    }
}
