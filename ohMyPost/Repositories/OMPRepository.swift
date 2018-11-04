import ohMyPostBase
import Foundation
import Moya

class OMPRepository {
    let api: MoyaProvider<JSONPlaceholderAPI>
    
    init() {
        self.api = MoyaProvider<JSONPlaceholderAPI>()
    }
}

extension OMPRepository: PostAPI {
    func getPosts(callback: @escaping ([Post]) -> ()) {
        self.api.request(JSONPlaceholderAPI.posts) { result in
            switch result {
            case .success(let response):
                let posts: [Post]? = try? JSONDecoder().decode(Array<Post>.self, from: response.data)
                callback(posts ?? [])
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
