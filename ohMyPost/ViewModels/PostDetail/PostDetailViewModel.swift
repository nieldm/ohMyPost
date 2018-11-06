import Foundation
import ohMyPostBase
import RxSwift
import RxCocoa

class PostDetailViewModel {
    
    private let disposeBag = DisposeBag()
    
    let model: PostDetailModel
    let data: BehaviorRelay<[SectionOfPostDetail]>
    
    init(model: PostDetailModel) {
        self.model = model
        let postSection = SectionOfPostDetail(
            header: "Description",
            items: [PostDetailSection.post(model.post)]
        )
        self.data = BehaviorRelay<[SectionOfPostDetail]>(value: [postSection])
    }
    
    func load() {
        self.rx.getUser()
            .map { SectionOfPostDetail(header: "User", items: [PostDetailSection.user($0)]) }
            .map { section in
                var sections = self.data.value
                sections.append(section)
                return sections
            }
            .sorted()
            .bind(to: self.data)
            .disposed(by: self.disposeBag)
        
        self.rx.getComments()
            .map { comments -> [SectionOfPostDetail] in
                var commentSections = comments.map({ (comment) -> SectionOfPostDetail in
                    return SectionOfPostDetail(header: "Comment\(comment.id)", items: [PostDetailSection.comment(comment)])
                })
                let headerSection = SectionOfPostDetail(header: "Comments", items: [PostDetailSection.comments(comments)])
                commentSections.insert(headerSection, at: 0)
                return commentSections
            }
            .map { commentSections in
                let sections = self.data.value + commentSections
                return sections
            }
            .sorted()
            .bind(to: self.data)
            .disposed(by: self.disposeBag)
    }
}

fileprivate extension Observable where Element == Array<SectionOfPostDetail> {
    
    func sorted() -> Observable<Element> {
        return self.map { sections in
            return sections.sorted(by: { (lhs: SectionOfPostDetail, rhs: SectionOfPostDetail) -> Bool in
                return lhs.items.first?.position ?? 0 < rhs.items.first?.position ?? 0
            })
        }
    }
    
}
