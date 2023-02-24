//
//  UrlProtocol.swift
//  Infrastructure
//
//  Created by Carlos Silva on 23/02/23.
//

import Foundation

public protocol UrlProtocol {
    var url: URL? { get }
    var baseUrlString: String { get }
}

public extension UrlProtocol {
    var baseUrlString: String {
        return "https://kitsu.io/api/edge/"
    }
}
