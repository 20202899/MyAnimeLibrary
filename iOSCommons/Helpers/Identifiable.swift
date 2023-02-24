//
//  Identifiable.swift
//  Presentations
//
//  Created by Carlos Silva on 23/02/23.
//

public protocol Identifiable {
    static var identifier: String { get }
}

public extension Identifiable {
    static var identifier: String {
        return String(describing: Self.self)
    }
}
