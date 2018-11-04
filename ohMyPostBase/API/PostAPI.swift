import Foundation

public protocol PostAPI {
    func getPosts(callback: @escaping ([Post]) -> ())
}
