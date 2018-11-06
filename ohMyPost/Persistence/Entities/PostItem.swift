import Foundation
import CoreData
import ohMyPostBase

final class PostItem: NSManagedObject, Managed {
    @NSManaged fileprivate(set) var postId: Int16
    @NSManaged fileprivate(set) var favorite: Bool
    @NSManaged fileprivate(set) var read: Bool
    
    static func insert(into context: NSManagedObjectContext, post: Post) -> PostItem {
        let postItem: PostItem = context.insertObject()
        postItem.postId = Int16(post.id)
        postItem.read = true
        return postItem
    }
    
    func setAsRead() {
        self.read = true
    }
}
