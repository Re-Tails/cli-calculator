import Foundation

class Calculator {
    /// Perform Addition
    ///
    /// - Author: Jacktator
    /// - Parameters:
    ///   - no1: First number
    ///   - no2: Second number
    /// - Returns: The addition result
    ///
    /// - Warning: The result may yield Int overflow.
    /// - SeeAlso: https://developer.apple.com/documentation/swift/int/2884663-addingreportingoverflow
    func add(no1: Int, no2: Int) -> Int {
        return no1 + no2
    }
    func subtract(no1: Int, no2: Int) -> Int {
        return no1 - no2
    }
    func multiply(no1: Int, no2: Int) -> Int {
        return no1 * no2
    }
    func divide(no1: Int, no2: Int) -> Int {
        return no1 / no2
    }
    func remain(no1: Int, no2: Int) -> Int {
        return no1 % no2
    }
    
    func putValueInArray(value: Int, array: inout [String], index:Int) {
        array[index] = String(value)
        array.remove(at: index+1)
        array.remove(at: index-1)
        
    }
    
    func calculate(args: [String]) -> String {
        var items = args
        var stageOne:Bool = false
        var stageTwo:Bool = false
        
        var tempResult:Int = 0
        var signIndex:Int = 1
        if(items.count > 1){
            stageOne = true
        }
        
        while stageOne {
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
                stageOne = false
            }
            else {
                signIndex = signIndex + 2
            }
        }
        
        tempResult = 0
        signIndex = 1
        if(items.count > 1){
            stageTwo = true
        }
        while stageTwo {
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
                stageTwo = false
            }
            else {
                signIndex = signIndex + 2
            }
        }
        let result = String(Int(items[0])!)
        return(result)
    }
}
