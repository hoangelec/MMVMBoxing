import XCTest
@testable import FoundationKit

class ResultExtentionsTests: XCTestCase {
    private let generalError = TestError.generalError
    
    func testValue_withSuccess() {
        // given
        let sut: Result<Int, Error> = .success(1)
        
        // when
        let result = sut.value
        
        // then
        XCTAssertEqual(result, 1)
    }
    
    func testValue_withFailure() {
        // given
        let sut: Result<Int, Error> = .failure(generalError)
        
        // when
        let result = sut.value
        
        // then
        XCTAssertNil(result)
    }
    
    func testError_withFailure() {
        // given
        let sut: Result<Int, Error> = .failure(generalError)
        
        // when
        let result = sut.error
        
        // then
        XCTAssertEqual(result as? TestError, generalError)
    }
    
    func testError_withSucsess() {
        // given
        let sut: Result<Int, Error> = .success(1)
        
        // when
        let result = sut.error
        
        // then
        XCTAssertNil(result)
    }
}
