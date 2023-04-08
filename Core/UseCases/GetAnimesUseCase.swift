//
//  GetTodayAnimesUseCase.swift
//  Core
//
//  Created by Carlos Silva on 01/03/23.
//

import Foundation
import RxSwift

public protocol GetAnimesUseCase {
    func invoke(url: URL?) -> Observable<Animes>
}
