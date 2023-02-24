//
//  APIServicesRequestType.swift
//  Infrastructure
//
//  Created by Carlos Silva on 23/02/23.
//

import Foundation

public enum APIServicesRequestType: Hashable, UrlProtocol {
    case paginate(year: Int, limit: Int, offset: Int)
    case season(String)
    case trend
    
    public var url: URL? {
        switch self {
        case .paginate(let year, let limit, let offset):
            return URL(string: "\(baseUrlString)anime?filter[seasonYear]=\(year)&page[limit]=\(limit)&page[offset]=\(offset)")
            
        case .season(let text):
            return URL(string: "\(baseUrlString)anime?filter[season]=\(text)&filter[seasonYear]=2023&page[limit]=20&page[offset]=0")
            
        case .trend:
            return URL(string: "\(baseUrlString)trending/anime")
        }
    }
}
