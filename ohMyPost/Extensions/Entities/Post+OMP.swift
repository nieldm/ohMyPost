import Foundation
import ohMyPostBase

//TODO: Replace this with a query result
extension Post {
    
    var favorite: () -> Bool {
        return { true }
    }
    
    var unread: () -> Bool {
        return { true }
    }
    
}
