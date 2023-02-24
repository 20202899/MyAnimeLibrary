//
//  APIServiceProtocol.swift
//  Infrastructure
//
//  Created by Carlos Silva on 23/02/23.
//

import Foundation
import Core

public protocol APIServiceProtocol {
    func request<T: Decodable>(_ request: UrlProtocol, completion: @escaping (Result<T, HttpErrorType>) -> Void)
}
