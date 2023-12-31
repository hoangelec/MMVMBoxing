// Generated using Sourcery 2.0.3 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif
























public class NetworkingSessionMock: NetworkingSession {

    public init() {}



    //MARK: - data

    public var dataForThrowableError: Error?
    public var dataForCallsCount = 0
    public var dataForCalled: Bool {
        return dataForCallsCount > 0
    }
    public var dataForReceivedRequest: (URLRequest)?
    public var dataForReceivedInvocations: [(URLRequest)] = []
    public var dataForReturnValue: (Data, URLResponse)!
    public var dataForClosure: ((URLRequest) async throws -> (Data, URLResponse))?

    public func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = dataForThrowableError {
            throw error
        }
        dataForCallsCount += 1
        dataForReceivedRequest = request
        dataForReceivedInvocations.append(request)
        if let dataForClosure = dataForClosure {
            return try await dataForClosure(request)
        } else {
            return dataForReturnValue
        }
    }

}
