//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var str = "Hello, playground"

let queue = OperationQueue.main

var myNumber = 0

let operation = BlockOperation {
    print("Main in myOp")
    myNumber = 1
}
queue.addOperation(operation)
//queue.waitUntilAllOperationsAreFinished()

print ("My number is \(myNumber)")

DispatchQueue.global(qos: .background).async {
    print("In background")
}
DispatchQueue.main.async {
    print("Inside loop")
}
print("Got past")
