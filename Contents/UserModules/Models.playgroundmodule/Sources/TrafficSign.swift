import Foundation

public struct TrafficSign: Hashable, Codable, Identifiable {
    public let id: Int
    public let name: String
    public let imageName: String
    public let category: String
    public let description: String?
}
