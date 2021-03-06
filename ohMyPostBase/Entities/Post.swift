import Foundation

public struct Post: Codable {
    public let id: Int
    public let userId: Int
    public let title: String
    public let body: String
    public let favorited = false
    public let read = false
}

extension Post: Equatable {
    public static func ==(lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }
}
