//
//  RemoteGetAnimesDataSource.swift
//  Core
//
//  Created by Carlos Silva on 23/02/23.
//

import Foundation

public protocol RemoteGetAnimesDataSource {
    func getAnimes(completion: @escaping (Result<Animes, HttpErrorType>) -> Void)
    func getTodayAnimes(completion: @escaping (Result<[Animes], HttpErrorType>) -> Void)
}
