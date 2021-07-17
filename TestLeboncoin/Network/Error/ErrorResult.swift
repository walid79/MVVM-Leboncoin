//
//  ErrorResult.swift
//  TestLeboncoin
//
//  Created by walid nakbi on 14/7/2021.
//

import Foundation
enum ErrorResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
}

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}
