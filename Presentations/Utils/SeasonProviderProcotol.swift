//
//  SeasonProviderProcotol.swift
//  Presentations
//
//  Created by Carlos Silva on 08/04/23.
//

import Foundation

protocol SeasonProviderProtocol {
    var season: String { get }
    var name: String { get set }
    var month: Int { get }
    var winter: String { get }
    var spring: String { get }
    var summer: String { get }
    var autumn: String { get }
}

extension SeasonProviderProtocol {
    var month: Int {
        let date = Date()
        return Calendar.current.component(.month, from: date)
    }
    
    var winter: String {
        return "winter"
    }
    var spring: String {
        return "spring"
    }
    var summer: String {
        return "summer"
    }
    var autumn: String {
        return "autumn"
    }
}

public final class SeasonProvider: SeasonProviderProtocol {
    static let shared: SeasonProvider = SeasonProvider()
    
    private init() { }
    
    var season: String {
        if month == 12 || month == 1 || month == 2 {
            name = "inverno"
            return winter
        } else if month == 3 || month == 4 || month == 5 {
            name = "primavera"
            return spring
        } else if month == 8 || month == 7 || month == 6 {
            name = "verão"
            return summer
        } else {
            name = "outono"
            return autumn
        }
    }
    
    var name: String = String()
}
