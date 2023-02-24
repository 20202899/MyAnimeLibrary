//
//  AnimesWorkerProtocol.swift
//  Presentations
//
//  Created by Carlos Silva on 23/02/23.
//

import Foundation
import Core

protocol AnimesWorkerProtocol {
    func getAnimes(completion: @escaping (Result<Animes, HttpErrorType>) -> Void)
}
