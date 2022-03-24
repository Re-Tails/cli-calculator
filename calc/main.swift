import Foundation

var args = ProcessInfo.processInfo.arguments
args.removeFirst() // remove the name of the program


var validArgs:Bool = true
// Check arguments count is odd
if args.count % 2 != 1 {
    validArgs = false
}
// Check numbers are valid
for i in stride(from: 0, to: args.count, by: 2){
    guard let _ = Int(args[i]) else{
        validArgs = false
        break
    }
}
// Check signs are valid
for i in stride(from: 1, to: args.count, by: 2){
    guard ["+", "-", "x", "/", "%"].contains(args[i]) else{
        validArgs = false
        break
    }
}


guard validArgs else {
    print("Invalid arguments")
    exit(1)
}

// Initialize a Calculator object
let calculator = Calculator()
// Calculate the result
var result = calculator.calculate(args: args)
print(result)
exit(0)
