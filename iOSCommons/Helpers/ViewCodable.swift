//
//  ViewCodable.swift
//  Presentations
//
//  Created by Carlos Silva on 23/02/23.
//

public protocol ViewCodable {
    func setupViews()
    func addViews()
    func addConstraints()
    func startCoded()
}

public extension ViewCodable {
    func startCoded() {
        self.setupViews()
        self.addViews()
        self.addConstraints()
    }
}
