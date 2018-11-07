import Moya
import Foundation

enum JSONPlaceholderAPI {
    case posts
    case post(id: Int)
    case comments(postId: Int)
    case user(id: Int)
}

extension JSONPlaceholderAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        switch self {
        case .posts:
            return "/posts"
        case .post(let id):
            return "/posts/\(id)"
        case .comments(let postId):
            return "/posts/\(postId)/comments"
        case .user(let id):
            return "/users/\(id)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        switch self {
        case .posts:
            guard let
                path = Bundle.main.path(forResource: "postsResponse", ofType: "json"),
                let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                    return Data()
            }
            return data
        default: return Data()
        }
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
