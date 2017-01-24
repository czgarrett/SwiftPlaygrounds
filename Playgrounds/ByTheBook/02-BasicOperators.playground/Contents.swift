// Chapter 2: Basic Operators

// Assignment Operator: =
var applesInBasket = 5
applesInBasket = 4

applesInBasket // now equals 4

let (pointA, pointB) = (3.5, 5.2)


// Arithmetic Operators
2 + 2   // equals 4 (not 🐟)
3 - 2   // equals 1
10 / 5  // equals 2
5 * 5   // equals 25

// Concatenation
let foobar = "foo, " + "bar" // equals "foo, bar"

// Remainder Operator
var remainder = 10 % 6   // equals 4 because 6 divides into 10 once
                         // and leaves us with a remainder of 4

// Unary Minus Operator
var forty = 40
var negativeForty = -forty // equivalent of assigning var to be -40 (negative 40)

// Unary Plus Operator
var minusSeven = -7
var stillMinusSeven = +minusSeven

// this operator actually doesn't do anything
// but can provide symmetry to code

// Compound Assignment Operators

var x = 10
x += 1  // shorthand for x = x + 1

var y = 5
y -= 3 // shorthand for y = y - 3



