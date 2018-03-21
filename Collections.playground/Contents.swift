//: Playground - noun: a place where people can play

import UIKit

let array = ["A", "B", "C", "A"]
// Method 1:  use reduce.  Works, but a little hard to read if it's compact like this
let aCount = array.reduce(0) {
    return $1 == "A" ? $0 + 1 : $0
}
// Method 2: Easier to read
let onlyA = array.filter { $0 == "A" }
let aCount2 = onlyA.count

array.forEach { print($0) }
