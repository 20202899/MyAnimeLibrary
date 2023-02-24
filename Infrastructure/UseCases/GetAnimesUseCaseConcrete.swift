//
//  GetAnimesUseCaseConcrete.swift
//  Infrastructure
//
//  Created by Carlos Silva on 23/02/23.
//

import Foundation
import Core

public final class GetAnimesUseCaseConcrete {
    private let repository: AnimesRepository
    
    public init(repository: AnimesRepository) {
        self.repository = repository
    }
}

extension GetAnimesUseCaseConcrete: GetAnimesUseCase {
    public func getAnimes(completion: @escaping (Result<Animes, HttpErrorType>) -> Void) {
        repository.fetchAnimes(completion: completion)
    }
}
