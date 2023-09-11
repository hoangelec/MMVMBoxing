import XCTest
import Foundation
import FoundationKit
@testable import NetworkKit

final class DecoderMock: ModelDecoder {
    var shouldThrowError = false // Customize this for testing error cases
    var decodedValue: Any?

    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        if shouldThrowError {
            throw NSError(domain: "MockJSONDecoder", code: 1, userInfo: nil)
        } else if let decodedValue = decodedValue as? T {
            return decodedValue
        } else {
            throw NSError(domain: "MockJSONDecoder", code: 2, userInfo: nil)
        }
    }
}

class DefaultNetworkClientTests: XCTestCase {
    var sut: DefaultNetworkClient!
    var decoder: DecoderMock!
    var session: NetworkingSessionMock!
    let testUrl = URL(string: "google.com.vn")!
    
    override  func setUp() {
        super.setUp()
        decoder = .init()
        session = .init()
        sut = .init(jsonDecoder: decoder, session: session)
    }
        
    func testRequest_sessionThrowsError() async throws {
        // given
        session.dataForThrowableError = "Fake error"
        
        // when
        var expectedError: Error?
        do {
            let _: String = try await sut.request(url: testUrl, method: .get, headers: nil, parameters: nil)
        } catch {
            expectedError = error
        }
        
        // then
        XCTAssertEqual(expectedError?.localizedDescription, "Fake error")
    }
    
    func testRequest_invalidResponseStatusCode() async throws {
        // given
        session.dataForReturnValue = (Data(), HTTPURLResponse.init(url: .init(string: "www.google.com")!, statusCode: 401, httpVersion: nil, headerFields: nil)!)
        
        // when
        var expectedError: Error?
        do {
            let _: String = try await sut.request(url: testUrl, method: .get, headers: nil, parameters: nil)
        } catch {
            expectedError = error
        }
        
        // then
        XCTAssertEqual(expectedError?.localizedDescription, "Error encountered. Status code 401")
    }
}
