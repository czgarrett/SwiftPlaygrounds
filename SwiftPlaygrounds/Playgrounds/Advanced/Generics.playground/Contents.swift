
//class Foo {
//    let barType: Bar.Type
//    
//    init(barType: Bar.Type) {
//        self.barType = barType
//    }
//    
//    func arrayOfOne() -> [Bar] {
//        var result = Array<self.barType>()
//    }
//}
//
//class Bar {
//    var description: String {
//        return "I'm a bar"
//    }
//    
//}
//
//class Pub: Bar {
//    override var description: String {
//        return "I'm a pub"
//    }
//}
//

import Foundation

protocol OrderedSetType {
    func typedArray<FilterType>() -> [FilterType]
}
extension NSOrderedSet: OrderedSetType {
    func typedArray<FilterType>() -> [FilterType] {
        var result: [FilterType] = []
        print("Result type is \(type(of: result))")
        for item in self.objectEnumerator() {
            print("Item type is \(type(of: item))")
            if let correctItem = item as? FilterType {
                result.append(correctItem)
            }
        }
        return result
    }
}

extension Optional where Wrapped: OrderedSetType {
    func typedArray<FilterType>() -> [FilterType] {
        switch self {
        case .none:
            return Array<FilterType>()
        case .some(let orderedSet):
            return orderedSet.typedArray()
        }
    }
}

let setOfStrings = NSMutableOrderedSet()
setOfStrings.add("String one")

let array: [String] = setOfStrings.typedArray()

let types: [Any.Type] = [String.self, Int.self]

for type in types {
    let array = Array<type(of: type).Type>()
}

