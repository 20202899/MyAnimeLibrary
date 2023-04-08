//
//  GetTodayAnimesUseCaseConcrete.swift
//  Infrastructure
//
//  Created by Carlos Silva on 01/03/23.
//

import Foundation
import Core
import RxSwift

public final class GetAnimesUseCaseConcrete {
    private let repository: AnimesRepository
    
    public init(repository: AnimesRepository) {
        self.repository = repository
    }
}

extension GetAnimesUseCaseConcrete: GetAnimesUseCase {
    public func invoke(url: URL?) -> Observable<Animes> {
        return repository.fetchAnimes(url: url)
    }
}
