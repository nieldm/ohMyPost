import Foundation

public class PostDetailModel {
    private let api: PostDetailAPI
    public let post: Post
    
    public init(api: PostDetailAPI, post: Post) {
        self.api = api
        self.post = post
    }
    
    public func getUser(callback: @escaping (User?) -> ()) {
        self.api.getUser(userId: self.post.userId, callback: callback)
    }
    
    public func getComment(callback: @escaping ([Comment]) -> ()) {
        self.api.getComment(postId: self.post.id, callback: callback)
    }
    
}
