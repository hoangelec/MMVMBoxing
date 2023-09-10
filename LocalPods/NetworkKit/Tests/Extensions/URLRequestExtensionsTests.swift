import XCTest
import Foundation
@testable import NetworkKit

class URLExtentionsTests: XCTestCase {
    func testAppendingQueryItem() {
        // given
        let sut = URL.init(string: "www.google.com")!
        
        // when
        let result = sut.appendingQueryItem(name: "name", value: "value")
        
        // then
        XCTAssertEqual(result?.absoluteString, "www.google.com?name=value")
    }
}

