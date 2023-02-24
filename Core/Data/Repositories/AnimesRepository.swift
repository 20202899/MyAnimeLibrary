//
//  AnimesRepository.swift
//  Core
//
//  Created by Carlos Silva on 23/02/23.
//

import Foundation

public protocol AnimesRepository {
    func fetchAnimes(completion: @escaping (Result<Animes, HttpErrorType>) -> Void)
}
