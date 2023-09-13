//
//  AppConfiguration.swift
//  Alamofire
//
//  Created by Hoang Cap on 09/09/2023.
//

public enum AppConfiguration {
    static var globalConfiguration: AppConfiguration = .debug
    case debug // dev env
    case release // prod env
}

public protocol AppConfigurator: AnyObject {
    var currentConfiguration: AppConfiguration { get }
    func setAppConfiguration(_ configuration: AppConfiguration)
}

public class DefaultAppConfigurator: AppConfigurator {
    public static let shared = DefaultAppConfigurator()
    
    public var currentConfiguration: AppConfiguration = .debug
    
    public func setAppConfiguration(_ configuration: AppConfiguration) {
        self.currentConfiguration = configuration
    }
}
