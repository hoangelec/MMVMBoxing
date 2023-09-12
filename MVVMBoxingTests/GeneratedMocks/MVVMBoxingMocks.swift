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

@testable import MVVMBoxing

class CoordinatorMock: Coordinator {




    //MARK: - start

    var startCallsCount = 0
    var startCalled: Bool {
        return startCallsCount > 0
    }
    var startReturnValue: UIViewController!
    var startClosure: (() -> UIViewController)?
    @discardableResult
    func start() -> UIViewController {
        startCallsCount += 1
        if let startClosure = startClosure {
            return startClosure()
        } else {
            return startReturnValue
        }
    }

}
