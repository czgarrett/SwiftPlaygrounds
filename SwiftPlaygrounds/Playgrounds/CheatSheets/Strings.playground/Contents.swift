//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let start = str.startIndex
let mid = str.index(start, offsetBy: 4)
str.substring(with: mid ..< str.index(after: mid))

var characterSet = CharacterSet.urlQueryAllowed
characterSet.remove(charactersIn: "+")
"Chris+Garrett@zworkbench.com".addingPercentEncoding(withAllowedCharacters: characterSet)

"🐿-8".characters.count
"🐿-8".unicodeScalars.count

