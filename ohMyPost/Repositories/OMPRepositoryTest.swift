import XCTest
@testable import ohMyPost

class OMPRepositoryTest: XCTestCase {

    var sut: OMPRepository!
    
    override func setUp() {
        self.sut = OMPRepository()
    }

    func test_getPosts() {
        let expectation = XCTestExpectation(description: "response")
        self.sut.getPosts { (posts) in
            XCTAssertGreaterThan(posts.count, 0)
            expectation.fulfill()
        }
    }
    
    func test_firstPost() {
        let expectation = XCTestExpectation(description: "Load Posts")
        self.sut.getPosts { (posts) in
            guard let post = posts.first else {
                fatalError("No Posts")
            }
            XCTAssertEqual(post.title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
            XCTAssertEqual(post.body, "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
            expectation.fulfill()
        }
    }

}
