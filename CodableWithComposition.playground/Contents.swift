
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

// To Handle different types of bikes using composition instead of inheritance, we can add some enums and feature types

enum BikeType: String, Codable {
    case road
    case mountain
}

struct BikeFeature: Codable {
    let name: String
}


class Bike: Codable {

    var make: String?
    var model: String?
    var size: BikeSize?
    var wheels: [BikeWheel] = []
    var features: [BikeFeature] = []
    let type: BikeType
    // We can't do this:
    // let prices: [Any]
    // Or this:
    // let prices: [Codable]
    // But we can do a specific type of codable such as an array of Doubles
    var prices: [Double] = []
    
    init(type: BikeType, make: String, model: String, size: BikeSize, wheels: [BikeWheel], prices: [Double]) {
        self.type = type
        self.make = make
        self.model = model
        self.size = size
        self.wheels = wheels
        self.prices = prices
    }
    
}

let mountainBike = Bike(type: .mountain, make: "Specialized", model: "Carbon Camber Comp", size: .name("L"), wheels: [wheel, wheel], prices: [2999.0])
mountainBike.features.append(BikeFeature(name: "Suspension"))

let roadBike = Bike(type: .road, make: "Specialized", model: "Allez Comp", size: .name("M"), wheels: [wheel, wheel], prices: [4999.0])

// An array of two different kinds of Bike:

let array = [mountainBike, roadBike]

try encodeAndPrint(array)

try encodeAndPrint(array)

let arrayData = try encodeJSON(array)

// Unfortunately this will just decode everything as a bike
try decodeAndPrint(Array<Bike>.self, data: arrayData)

