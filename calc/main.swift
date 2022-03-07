import Foundation

var args = ProcessInfo.processInfo.arguments
args.removeFirst() // remove the name of the program

// Initialize a Calculator object
let calculator = Calculator();

var result = calculator.calculate(args: args);
// Calculate the result

print(result)
