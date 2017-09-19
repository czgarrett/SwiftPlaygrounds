
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
try encodeAndPrint(wheel)


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

struct Bike: Codable {
    let make: String
    let model: String
    let size: BikeSize
    let wheels: [BikeWheel]
    // We can't do this:
    // let prices: [Any]
    // Or this:
    // let prices: [Codable]
    // But we can do a specific type of codable such as an array of Doubles
    let prices: [Double]
}

let bike = Bike(make: "Specialized", model: "Carbon Camber Comp", size: .name("L"), wheels: [wheel, wheel], prices: [2999.0])
try encodeAndPrint(bike)

// Okay, so what would happen if we had encoded a bunch of objects, stored them in a database and then changed the name of the class?
// Let's rename our struct above to a new type called MountainBike.

// Store our previous bike
let bikeData = try encodeJSON(bike)

// Create a struct as above but with some changes
struct MountainBike: Codable {
    let make: String
    let model: String
    let size: BikeSize
    let wheels: [BikeWheel]
    // Deleted prices
}

// Try to decode our mountain bike from previous bike data
try decodeAndPrint(MountainBike.self, data: bikeData)
// Whoa, it works!  That's great because it means that the decoder will gracefully handle many changes

// But let's say we did something more complicated like renamed or add new required properties.  Let's try it with a road bike struct.
struct RoadBike: Codable {
    let make: String
    let model: String
    let size: BikeSize
    let wheels: [BikeWheel]
    // Renamed prices to offers
    let offers: [Double]
    // Added new non-optional property called seat
    let seat: String
}

// The above struct won't decode properly and you'll get an error.
// So you need to extend the struct to create your own initializer

extension RoadBike {
    // Coding keys are vastly preferable to strings because the compiler is more likely to pick up errors
    enum CodingKeys: String, CodingKey {
        case make
        case model
        case size
        case wheels
        case offers = "prices" // lets us handle the property rename in one place
        case seat
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let make = try values.decode(String.self, forKey: .make)
        let model = try values.decode(String.self, forKey: .model)
        let size = try values.decode(BikeSize.self, forKey: .size)
        let wheels = try values.decode([BikeWheel].self, forKey: .wheels)
        let offers = try values.decode([Double].self, forKey: .offers)
        let seat = (try? values.decode(String.self, forKey: .seat)) ?? "Unknown" // Handle the fact that seat is a new, nonoptional property
        self = RoadBike(make: make, model: model, size: size, wheels: wheels, offers: offers, seat: seat)
        return
    }
}

do {
    try decodeAndPrint(RoadBike.self, data: bikeData)
} catch (let error) {
    print("Error decoding road bike: \(error)")
}

//////////////////////////////////////////////////////////
/// Discussion
///
/// You don't really get encoding "for free" with Swift 4, in the sense that the compiler magically can encode everything
/// Instead you get free structs, classes, primitive objects, and simple enums.  When I first saw the presentation I was wondering
/// How JSON would get created for associated value enums or arrays of heterogeneous types.  Now I know - you have to create it yourself.
///
///////////////////////////////////////////////////////

