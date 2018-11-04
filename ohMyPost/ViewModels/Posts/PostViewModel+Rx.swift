import Foundation
import RxSwift
import ohMyPostBase

extension PostViewModel: ReactiveCompatible {}

extension Reactive where Base == PostViewModel {
    
    func getPosts() -> Observable<[Post]> {
        return Observable.create { observer in
            self.base.model.loadPosts(callback: { (posts) in
                observer.onNext(posts)
                observer.onCompleted()
            })
            return Disposables.create()
        }
    }
    
}
