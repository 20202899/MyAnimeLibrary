//
//  LayoutSpacing.swift
//  iOSCommons
//
//  Created by Carlos Silva on 25/02/23.
//

import CoreGraphics

public protocol LayoutSpacingProtocol {
    var value: CGFloat { get }
}

public enum LayoutSpacing: LayoutSpacingProtocol {
    case s0
    case s4
    case s8
    case s12
    case s16
    case s20
    case s24
    case s26
    case s28
    case s30
    case s34
    case s36
    case s38
    case s40
    case s44
    case s46
    case s48
    case s50
    case s54
    
    public var value: CGFloat {
        switch self {
        case .s0:
            return 0
            
        case .s4:
            return 4
            
        case .s8:
            return 8
            
        case .s12:
            return 12
            
        case .s16:
            return 16
            
        case .s20:
            return 20
            
        case .s24:
            return 24
            
        case .s26:
            return 26
            
        case .s28:
            return 28
            
        case .s30:
            return 30
            
        case .s34:
            return 34
            
        case .s36:
            return 36
            
        case .s38:
            return 38
            
        case .s40:
            return 40
            
        case .s44:
            return 44
            
        case .s46:
            return 46
            
        case .s48:
            return 48
            
        case .s50:
            return 50
            
        case .s54:
            return 54
        }
    }
}
