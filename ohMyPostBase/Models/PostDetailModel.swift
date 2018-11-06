import Foundation

class PostDetailModel {
    private let api: PostDetailAPI
    private let postId: Int
    
    public init(api: PostDetailAPI, postId: Int) {
        self.api = api
        self.postId = postId
    }
    
    func getUser(callback: @escaping (User?) -> ()) {
        self.api.getUser(postId: self.postId, callback: callback)
    }
    
    func getComment(callback: @escaping ([Comment]) -> ()) {
        self.api.getComment(postId: self.postId, callback: callback)
    }
    
}
