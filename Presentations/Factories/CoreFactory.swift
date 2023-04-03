//
//  CoreFactory.swift
//  Presentations
//
//  Created by Carlos Silva on 23/02/23.
//

import Foundation
import Core
import Infrastructure

func makeRemoteGetAnimesDataSource() -> RemoteGetAnimesDataSource {
    return AlamofireDataSource()
}

func makeAnimesRepository() -> AnimesRepository {
    return AnimesRemoteRepository(remoteGetAnimesDataSource: makeRemoteGetAnimesDataSource())
}

func makeGetTodayAnimesUseCase() -> GetTodayAnimesUseCase {
    return GetTodayAnimesUseCaseConcrete(repository: makeAnimesRepository())
}
