//: Playground - noun: a place where people can play

import UIKit

struct Auto {
    var make: String
    var model: String
}

// Hard coding data in code usually isn't a good idea.  But there are cases
// where you have a bunch of semi-structured data in your code.
// Tuples are a great use for this kind of thing.

// We "could" have an array of calls to the Auto constructor here.
// But that would involve quite a bit more duplicated code on each line.
// This approach has the minimal amount of repeated code, while still keeping it structured.
// Then we iterate over it all to convert it into autos.
let data: [(make: String, model: String)] = [
    ("Ford", "Focus"),
    ("Chevy", "Bolt"),
    ("Chevy", "Camaro"),
    ("Tesla", "Model S"),
]

// Convert the data to Auto instances
let cars = data.map { carData in
    return Auto(make: carData.make, model: carData.model)
}

