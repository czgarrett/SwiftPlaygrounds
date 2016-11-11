//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let start = str.startIndex
let mid = str.index(start, offsetBy: 4)
str.substring(with: mid ..< str.index(after: mid))
