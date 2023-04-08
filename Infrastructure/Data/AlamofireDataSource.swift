//
//  AlamofireDataSource.swift
//  Infrastructure
//
//  Created by Carlos Silva on 23/02/23.
//

import Foundation
import Core
import RxSwift

public final class AlamofireDataSource {
    private let service: APIServiceProtocol
    private var url: URL?
    
    public init() {
        self.service = APIServices.shared
    }
}

extension AlamofireDataSource: RemoteGetAnimesDataSource {
    public func getAnimes(url: URL?) -> Observable<Animes> {
        return service.request(url)
    }
}
