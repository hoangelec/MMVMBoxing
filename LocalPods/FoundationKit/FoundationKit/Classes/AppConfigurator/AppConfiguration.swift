//
//  AppConfiguration.swift
//  Alamofire
//
//  Created by Hoang Cap on 09/09/2023.
//

public enum AppConfiguration {
    case debug // dev env
    case release // prod env
}

/// The single source of truth for the configuration the app is running on
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
