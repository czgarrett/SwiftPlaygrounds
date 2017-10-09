//: Playground - noun: a place where people can play

import UIKit

let formatter = DateFormatter()
let isoFormatter = ISO8601DateFormatter()

formatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSSSSSZZZZZ"

formatter.string(from: Date())
isoFormatter.string(from: Date())
