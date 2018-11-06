import Foundation

protocol PostDetailAPI {
    func getUser(postId: Int, callback: @escaping (User?) -> ())
    func getComment(postId: Int, callback: @escaping ([Comment]) -> ())
}
