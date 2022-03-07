import Foundation

class Calculator {
    
    /// For multi-step calculation, it's helpful to persist existing result
    var currentResult = 0
    
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
            var itemsChanged:Bool = false
            switch(items[signIndex]) {
            case "x":
                tempResult = Int(items[signIndex-1])! * Int(items[signIndex+1])!
                itemsChanged = true
            case "/":
                tempResult = Int(items[signIndex-1])! / Int(items[signIndex+1])!
                itemsChanged = true
            case "%":
                tempResult = Int(items[signIndex-1])! % Int(items[signIndex+1])!
                itemsChanged = true
            default:
                ()
            }
            if(itemsChanged) {
                items[signIndex] = String(tempResult)
                items.remove(at: signIndex+1)
                items.remove(at: signIndex-1)
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
            var itemsChanged:Bool = false
            switch(items[signIndex]) {
            case "+":
                tempResult = Int(items[signIndex-1])! + Int(items[signIndex+1])!
                itemsChanged = true
            case "-":
                tempResult = Int(items[signIndex-1])! - Int(items[signIndex+1])!
                itemsChanged = true
            default:
                ()
            }
            if(itemsChanged) {
                items[signIndex] = String(tempResult)
                items.remove(at: signIndex+1)
                items.remove(at: signIndex-1)
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
