//
//  RemoteAnimesRepository.swift
//  Infrastructure
//
//  Created by Carlos Silva on 23/02/23.
//

import Foundation
import Core

public final class AnimesRemoteRepository {
    private let remoteGetAnimesDataSource: RemoteGetAnimesDataSource
    
    public init(remoteGetAnimesDataSource: RemoteGetAnimesDataSource) {
        self.remoteGetAnimesDataSource = remoteGetAnimesDataSource
    }
}

extension AnimesRemoteRepository: AnimesRepository {
    public func fetchAnimes(completion: @escaping (Result<Animes, HttpErrorType>) -> Void) {
        remoteGetAnimesDataSource.getAnimes(completion: completion)
    }
}
