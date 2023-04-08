//
//  RemoteGetAnimesDataSource.swift
//  Core
//
//  Created by Carlos Silva on 23/02/23.
//

import Foundation
import RxSwift

public protocol RemoteGetAnimesDataSource {
    func getAnimes(url: URL?) -> Observable<Animes>
}
