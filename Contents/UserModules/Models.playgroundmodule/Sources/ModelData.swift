import Foundation

// load all traffic signs with traffic sign model
public let trafficSigns: [TrafficSign] = load("traffic-signs.json")

// load json
private func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    // load file from main bundle
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else { fatalError("Could not find \(filename) in main bundle.") }
    
    // try to get the data from loaded file
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Could not load \(filename) from main bundle.")
    }
    
    // try to decode into the given model
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Could not parse \(filename) as \(T.self).")
    }
}
