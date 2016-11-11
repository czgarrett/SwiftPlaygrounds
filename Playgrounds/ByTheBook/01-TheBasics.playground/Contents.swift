// Chapter 1: The Basics

// Comments
// This is a single-line comment

/* This is a block comment
   and can expand over 
   multiple lines */

// Declaring Constants and Variables
let frisbeeShape = "circle" // constant
var applesInBasket = 10 // variable

// Declaring Multiple Variables
var oranges = 10, bananas = 5, peaches = 7

// Declaring Variable of Certain Type
var distance: Double
distance = 34.7

var error: String
error = "File could not be found"

// Define Multiple Variables of Same Type
var quarters, dimes, nickles: Int

// Declaring Type and Value
var message: String = "hello"

// Naming Constants and Variables
let θ = 2.5
let ελληνικά = "Greek"
let 🙃 = "life"

// Change Value of Variable
var currentLanguage = "English"
currentLanguage = "Spanish" // currentLanguage now set to "Spanish"

// Printing Constants and Variables
print(currentLanguage) // prints "Spanish"

// Printing Text with a Variable
print("The current language is \(currentLanguage)")

// Semicolons
// They are optional, but required for multiple statements on one line
var year = 1999; print(year)

// Integer Bounds
var min = UInt.min      // 0
var min_16 = UInt16.min // 0
var min_32 = UInt32.min // 0

var max = UInt.max      // on 32-bit machine, same size Int32; on 64-bit machine, same size as Int64
var max_16 = UInt16.max // 65535
var max_32 = UInt32.max // 4294967295
var max_64 = UInt64.max // 18446744073709551615

// UInt's cannot store values below their min range or above their max
// let notNegative: UInt = -1 // UInt's cannot store below 1
// let notOver: Int16 = Int16.max + 1 // UInt's cannot store over their max value

// Type Safety
let massOfCarbon = 12.011 // inferred to be type Double
let AtomicNumberOfCarbon = 27 // inferred to be type Int

// When a variable's type is inferred, any declarations must be of the same type
var batteryLife = 4
// batteryLife = 3.8 // Cannot assign value of type 'Double' to type 'Int'

// Number Literals
let decimalInt = 15
let binaryInt = 0b1111      // 15 in binary notation
let octalInt = 0o17         // 15 in octal notation
let hexadecimalInt = 0xf    // 15 in hex notation

// Decimal Float Exponents
var decExp = 2.5e2 // 2.5 * 10^2

// Hexadecimal Float Exponents
var hexExp = 0xAp2 // 10 * 2^2

// Type Aliases
// You can give alternate names to existing types
typealias NewTypeName = UInt32
var imageSize = NewTypeName.max // same value as UInt32.max

// Booleans
var pageLoaded = true
var isFull = false

// Conditionals
if pageLoaded {
    print("success")
}
else {
    print("failure")
}

// Type Safety In Conditionals
// Type safety prevents ints from being converted to Bool
var index = 1

// The following would throw an error
/*
if index {
    print("index exists")
} 
*/

// However this is allowed:
if index == 1 {
    print("index exists")
}

// Tuples
let http502Error = (404, "Bad Gateway") // this is type (Int, String)
print("The error code is \(http502Error.0)")
print("The error message is \(http502Error.1)")

// or you can assign tuple elements to variables

let (errorCode, errorMessage) = http502Error
print("The error code is \(errorCode)")
print("The error message is \(errorMessage)")

// you can ignore elements you don't need by using an underscore (_) when declaring tuple variables
let (onlyErrorCode, _) = http502Error
print("The error code is \(onlyErrorCode)")

let fruits = (numberOfFruits: 12, quality: "good")
print("We have \(fruits.numberOfFruits) fruits and their quality is \(fruits.quality)")

// Optionals
// indicate that a constant or variable can have no value
var serverState: Int? = 100
serverState = nil // serverState is now valueless

var secondsLeft: Int = 34
// secondsLeft = nil // throws error

// You can define optional variables of any type
var movieTitle: String? // movieTitle set to nil by default

// Optional Binding
var varFive = Int("5") // varFive has an integer value of 5
var varSeven = Int("7") // integer value of 7
if varFive < varSeven {
    print("True")
}
else {
    print("False")
}

// or you can create temporary variables in the if-statement
if var first = Int("20"), second = Int("123") where first < second {
    print("\(first) < \(second)")
}

//Error Handling

func funcWithError() throws {
    // function that can throw an error
}

//Try-Catch
do {
    try funcWithError()
    // continue if no error
} catch {
    // handle error
}

// Assertions
// occur when a conditional prevents a portion of code 
// from ever being run

let x = 5
if (x != 5) {
    print("This will never be reached")
}

// assertions check that a condition is guaranteed to evaluate to true
// assert(x != 5, "A person's age cannot be less than zero") // throws an error 

// assertion messages are optional 
let y = "world"
// assert(y != "world")

// "Use an assertion whenever a condition has the potential to be false, but must definitely be true in order for your code to continue execution."