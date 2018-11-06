import Foundation

public protocol PostDetailAPI {
    func getUser(userId: Int, callback: @escaping (User?) -> ())
    func getComment(postId: Int, callback: @escaping ([Comment]) -> ())
}
