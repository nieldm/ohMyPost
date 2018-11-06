import Foundation

public struct User: Codable {
    public let id: Int
    public let username: String
    public let name: String
    public let phone: String
    public let website: String
    public let email: String
}
