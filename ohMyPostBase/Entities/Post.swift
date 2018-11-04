import Foundation

public struct Post: Codable {
    let id: Int
    let userId: Int
    
    public let title: String
    public let body: String
}
