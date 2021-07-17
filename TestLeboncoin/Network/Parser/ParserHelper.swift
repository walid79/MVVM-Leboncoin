//
//  ParserHelper.swift
//  TestLeboncoin
//
//  Created by walid nakbi on 14/7/2021.
//

import Foundation
import CoreData
protocol Parseable {
    func parse<T: Decodable>(_ type: T.Type, from data: Data, completion: @escaping (Result<T, ErrorResult>) -> Void)
}

extension Parseable {
    /// Parsable data with model using codable protocol
    /// - Parameters:
    ///   - type: class type generic
    ///   - data: data
    ///   - completion: completion handler
    func parse<T: Decodable>(_ type: T.Type, from data: Data, completion: @escaping (Result<T, ErrorResult>) -> Void) {
        
        
        
        let jsonDecorder = JSONDecoder()
        do {
            let parseObject = try jsonDecorder.decode(type.self, from: data)
            completion(.success(parseObject))
        } catch {
            print(error)
            completion(.failure(.parser(string: error.localizedDescription)))
        }
    }
}
