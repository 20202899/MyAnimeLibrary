//
//  AnimesRepository.swift
//  Core
//
//  Created by Carlos Silva on 23/02/23.
//

import Foundation
import RxSwift

public protocol AnimesRepository {
    func fetchAnimes(url: URL?) -> Observable<Animes>
}
