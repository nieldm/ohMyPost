import Foundation
import RxSwift
import ohMyPostBase

extension PostDetailViewModel: ReactiveCompatible {}

extension Reactive where Base == PostDetailViewModel {
    
    func getUser() -> Observable<User> {
        return Observable.create { observer in
            self.base.model.getUser { user in
                if let user = user {
                    observer.onNext(user)
                    observer.onCompleted()
                } else {
                    observer.onError(RxError.noElements)
                }
            }
            return Disposables.create()
        }
    }
    
    func getComments() -> Observable<[Comment]> {
        return Observable.create { observer in
            self.base.model.getComment { comments in
                observer.onNext(comments)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
}
