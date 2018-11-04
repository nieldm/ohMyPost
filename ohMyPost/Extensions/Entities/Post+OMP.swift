import Foundation
import ohMyPostBase
import RxDataSources

//TODO: Replace this with a query result
extension Post {
    
    var favorite: () -> Bool {
        return { true }
    }
    
    var unread: () -> Bool {
        return { true }
    }
    
}

extension Post: IdentifiableType {
    
    public typealias Identity = Int
    
    public var identity: Int {
        return self.id
    }
    
}

struct SectionOfPosts {
    
    var header: String
    var items: [Item]
    
}

extension SectionOfPosts: AnimatableSectionModelType {
    
    typealias Item = Post
    typealias Identity = String
    
    init(original: SectionOfPosts, items: [Item]) {
        self = original
        self.items = items
    }
    
    var identity: String {
        return self.header
    }
    
}
