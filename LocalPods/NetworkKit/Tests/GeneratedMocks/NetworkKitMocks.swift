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

@testable import NetworkKit

public class ImageLoaderMock: ImageLoader {

    public init() {}



    //MARK: - loadImage

    public var loadImageFromThrowableError: Error?
    public var loadImageFromCallsCount = 0
    public var loadImageFromCalled: Bool {
        return loadImageFromCallsCount > 0
    }
    public var loadImageFromReceivedUrl: (URL)?
    public var loadImageFromReceivedInvocations: [(URL)] = []
    public var loadImageFromReturnValue: UIImage!
    public var loadImageFromClosure: ((URL) async throws -> UIImage)?
    public func loadImage(from url: URL) async throws -> UIImage {
        if let error = loadImageFromThrowableError {
            throw error
        }
        loadImageFromCallsCount += 1
        loadImageFromReceivedUrl = url
        loadImageFromReceivedInvocations.append(url)
        if let loadImageFromClosure = loadImageFromClosure {
            return try await loadImageFromClosure(url)
        } else {
            return loadImageFromReturnValue
        }
    }

}
