//
//  HttpErrorType.swift
//  Core
//
//  Created by Carlos Silva on 23/02/23.
//

import Foundation

public enum HttpErrorType: Error {
    case noConnection
    case jsonParsing
    case unknown
}
