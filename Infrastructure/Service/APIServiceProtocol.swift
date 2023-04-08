//
//  APIServiceProtocol.swift
//  Infrastructure
//
//  Created by Carlos Silva on 23/02/23.
//

import Foundation
import Core
import RxSwift

public protocol APIServiceProtocol {
    func request<T: Decodable>(_ request: URL?) -> Observable<T>
}
