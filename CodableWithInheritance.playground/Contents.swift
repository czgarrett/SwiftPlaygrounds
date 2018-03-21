
import Foundation // needed for Encoder/Decoder

//////////////////////////////////////////////////////////
/// Some helper methods for our playground
///////////////////////////////////////////////////////


func encodeJSON<T:Codable>(_ codable: T) throws -> Data {
    let jsonEncoder = JSONEncoder()
    jsonEncoder.outputFormatting = .prettyPrinted
    return try jsonEncoder.encode(codable)
}

func encodeAndPrint<T:Codable>(_ codable: T) throws {
    let encodedData = try encodeJSON(codable)
    let json = String.init(data: encodedData, encoding: .utf8)!
    print("Here's the JSON for \(String(describing: codable)) encoded\n\n\(json)\n")
}

func decodeAndPrint<T:Codable>(_ type: T.Type, data: Data) throws {
    let decoder = JSONDecoder()
    let object = try decoder.decode(type, from: data)
    print("Result of decoding data: \n\(String(describing: object))\n")
}

///////////////////////////////////////////////////////////
/// Simple Example
///////////////////////////////////////////////////////


struct BikeWheel: Codable {
    let diameter: Float
    let make: String
    let spokes: Int
    let valveType: String?  // What do nil values look like when encoded?
}

// Encode a bikewheel to see its JSON

let wheel = BikeWheel(diameter: 26.0, make: "Mavic", spokes: 24, valveType: nil)


//////////////////////////////////////////////////////////
/// More complicated example
///////////////////////////////////////////////////////

// An enum with associated values
enum BikeSize: Codable {
    case topTube(length: Float)
    case name(String)
}

// For an associated value enum, we need to provide an implementation to encode/decode it
extension BikeSize {
    private enum CodingKeys: String, CodingKey {
        // Sometimes we want to conserve storage space for heavily used objects,
        // so we can use shorter keys for coding.
        case topTube = "t"
        case name = "n"
    }
    
    enum BikeSizeCodingError: Error {
        case missingKey(String)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? values.decode(Float.self, forKey: .topTube) {
            self = .topTube(length: value)
            return
        }
        if let value = try? values.decode(String.self, forKey: .name) {
            self = .name(value)
            return
        }
        throw BikeSizeCodingError.missingKey("Missing key")
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .topTube(let length):
            try container.encode(length, forKey: .topTube)
        case .name(let name):
            try container.encode(name, forKey: .name)
        }
    }
}

class Bike: Codable {
    private enum CodingKeys: String, CodingKey {
        // Sometimes we want to conserve storage space for heavily used objects,
        // so we can use shorter keys for coding.
        case make
        case model
        case size
        case wheels
        case prices
    }

    var make: String?
    var model: String?
    var size: BikeSize?
    var wheels: [BikeWheel] = []
    // We can't do this:
    // let prices: [Any]
    // Or this:
    // let prices: [Codable]
    // But we can do a specific type of codable such as an array of Doubles
    var prices: [Double] = []
    
    init(make: String, model: String, size: BikeSize, wheels: [BikeWheel], prices: [Double]) {
        self.make = make
        self.model = model
        self.size = size
        self.wheels = wheels
        self.prices = prices
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.make = try values.decode(String.self, forKey: .make)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.make, forKey: .make)
    }
    
}

// Create a subclass with some additional properties
class MountainBike: Bike {
    private enum CodingKeys: String, CodingKey {
        case suspension
    }
    var suspension: String = ""
    
    override init(make: String, model: String, size: BikeSize, wheels: [BikeWheel], prices: [Double]) {
        super.init(make: make, model: model, size: size, wheels: wheels, prices: prices)
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.suspension = try values.decode(String.self, forKey: .suspension)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.suspension, forKey: .suspension)
        try super.encode(to: encoder)
    }

}

let mountainBike = MountainBike(make: "Specialized", model: "Carbon Camber Comp", size: .name("L"), wheels: [wheel, wheel], prices: [2999.0])
mountainBike.suspension = "Front"
let roadBike = Bike(make: "Specialized", model: "Allez Comp", size: .name("M"), wheels: [wheel, wheel], prices: [4999.0])

try encodeAndPrint(mountainBike)

// Store our previous bike
let bikeData = try encodeJSON(mountainBike)


// Try to decode our mountain bike from previous bike data
try decodeAndPrint(Bike.self, data: bikeData)
// Note that the returned type is of type Bike, not Mountain Bike.  This is because the JSON doesn't have any info about which subclass it encodes,
// and the init method can't figure it out

// If we use the mountain bike class it works:
try decodeAndPrint(MountainBike.self, data: bikeData)

// An array of two different kinds of Bike:

let array = [mountainBike, roadBike]

try encodeAndPrint(array)

let arrayData = try encodeJSON(array)

// Unfortunately this will just decode everything as a bike
try decodeAndPrint(Array<Bike>.self, data: arrayData)

// If we want to do a heterogenous collection of Bike and its subclass types, we could use an enum to do this:

enum BikeReference: Codable {
    case bike(Bike)
    case mountainBike(MountainBike)
    
    enum BikeReferenceCodingError: Error {
        case missingKey
    }

    private enum CodingKeys: String, CodingKey {
        // Sometimes we want to conserve storage space for heavily used objects,
        // so we can use shorter keys for coding.
        case mountainBike = "m"
        case bike = "b"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if values.contains(.bike) {
            let bike = try values.decode(Bike.self, forKey: .bike)
            self = .bike(bike)
        } else if values.contains(.mountainBike) {
            let bike = try values.decode(MountainBike.self, forKey: .mountainBike)
            self = .mountainBike(bike)
        } else {
            throw BikeReferenceCodingError.missingKey
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .bike(let bike):
            try container.encode(bike, forKey: .bike)
        case .mountainBike(let mtb):
            try container.encode(mtb, forKey: .mountainBike)
        }
    }

}

// Now we can have an array of those references

let bikeRefs = [BikeReference.mountainBike(mountainBike), BikeReference.bike(roadBike)]
let heterogeneousData = try encodeJSON(bikeRefs)

// Unfortunately this will just decode everything as a bike
try decodeAndPrint(Array<BikeReference>.self, data: heterogeneousData)

//////////////////////////////////////////////////////////
/// Discussion
///
/// Swift inheritance + Codable seems to be a pain.  I'm going to work up another example that uses composition instead of inheritance to do the same thing.
///
///////////////////////////////////////////////////////


