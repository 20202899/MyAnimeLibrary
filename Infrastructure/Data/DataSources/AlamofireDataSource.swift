//
//  AlamofireDataSource.swift
//  Infrastructure
//
//  Created by Carlos Silva on 23/02/23.
//

import Foundation
import Core

public final class AlamofireDataSource {
    private let service: APIServiceProtocol
    private var url: UrlProtocol
    
    public init() {
        self.service = APIServices.shared
        self.url = APIServicesRequestType.trend
    }
}

extension AlamofireDataSource: RemoteGetAnimesDataSource {
    public func getAnimes(completion: @escaping (Result<Animes, HttpErrorType>) -> Void) {
        service.request(url, completion: completion)
    }
}
