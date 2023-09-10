//
//  ModelDecoder.swift
//  FoundationKit
//
//  Created by Hoang Cap on 09/09/2023.
//

public protocol ModelDecoder {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

extension JSONDecoder: ModelDecoder {}
