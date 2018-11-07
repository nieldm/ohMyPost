import Foundation
import CoreData
import ohMyPostBase

final class PostItem: NSManagedObject, Managed {
    @NSManaged fileprivate(set) var postId: Int16
    @NSManaged fileprivate(set) var favorite: Bool
    @NSManaged fileprivate(set) var read: Bool
    
    static func insert(into context: NSManagedObjectContext, post: Post, favorite: Bool = false) -> PostItem {
        let postItem: PostItem = context.insertObject()
        postItem.postId = Int16(post.id)
        postItem.read = true
        postItem.favorite = favorite
        return postItem
    }
    
    func setAsRead() {
        self.read = true
    }
    
    func toogleFavorite() {
        self.favorite.toggle()
    }
}
