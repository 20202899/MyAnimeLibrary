//
//  GetTodayAnimesUseCaseConcrete.swift
//  Infrastructure
//
//  Created by Carlos Silva on 01/03/23.
//

import Foundation
import Core

public final class GetTodayAnimesUseCaseConcrete {
    private let repository: AnimesRepository
    
    public init(repository: AnimesRepository) {
        self.repository = repository
    }
}

extension GetTodayAnimesUseCaseConcrete: GetTodayAnimesUseCase {
    public func getTodayAnimes(completion: @escaping (Result<[Animes], HttpErrorType>) -> Void) {
        repository.fetchTodayAnimes(completion: completion)
    }
}
