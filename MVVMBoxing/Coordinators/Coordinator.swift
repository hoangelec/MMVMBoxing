//
//  Coordinator.swift
//  MVVMBoxing
//
//  Created by Hoang Cap on 11/09/2023.
//

import UIKit

//sourcery: AutoMockable
protocol Coordinator: AnyObject {
    @discardableResult func start() -> UIViewController
}
