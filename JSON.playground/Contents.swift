//: Playground - noun: a place where people can play

import UIKit

var info: [String:Any] = [
    "firstName": "Chris",
    "lastName": "Garrett",
    "age": 45
]

// Single line JSON
let jsonData = try! JSONSerialization.data(withJSONObject: info, options: [])
let jsonString = String(data: jsonData, encoding: .utf8)
print("JSON formatted as a single line:")
print(jsonString!)
print()


// Pretty printed JSON
let prettyJsonData = try! JSONSerialization.data(withJSONObject: info, options: [.prettyPrinted])
let prettyJsonString = String(data: prettyJsonData, encoding: .utf8)
print("JSON formatted as a pretty string:")
print(prettyJsonString!)
