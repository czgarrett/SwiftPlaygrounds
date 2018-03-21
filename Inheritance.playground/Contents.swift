//: Playground - noun: a place where people can play

protocol Movable: Hashable {
    func calculateSpeed() -> Float
}

class MyBaseClass: Equatable, Hashable {
    var hashValue: Int {
        return 0
    }
    
    static func ==(lhs: MyBaseClass, rhs: MyBaseClass) -> Bool {
        return lhs === rhs
    }
    
    var name: String = "None"
    
}

extension Movable {
    func calculateSpeed() -> Float {
        print("In protocol implementation")
        return 0.0
    }
}

extension Movable where Self: MyBaseClass {
    
    func calculateSpeedOfRelatedItems() -> [Float] {
        var result: [Float] = []
        for item in self.relatedItems() {
            let speeds = item.relatedItems().map { $0.calculateSpeed() }
            result.append(contentsOf: speeds)
        }
        return result
    }
    
    func relatedItems() -> Set<Self> {
        return Set([self])
    }
}

extension Vehicle {
    func calculateSpeed() -> Float {
        print("In Vehicle extension")
        return 1.0
    }
}

class Vehicle: MyBaseClass {
    func calculateSpeed() -> Float {
        print("In Vehicle class")
        return 2.0
    }
}

class Automobile: Vehicle {
    func calculateSpeed() -> Float {
        print("In Automobile class")
        return 3.0
    }
}

class Car: Automobile, Movable {
//    override func calculateSpeed() -> Float {
//        return super.calculateSpeed()
//    }
}

let car = Car()

car.calculateSpeed()
