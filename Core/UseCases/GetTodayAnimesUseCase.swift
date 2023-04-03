//
//  GetTodayAnimesUseCase.swift
//  Core
//
//  Created by Carlos Silva on 01/03/23.
//

import Foundation

public protocol GetTodayAnimesUseCase {
    func getTodayAnimes(completion: @escaping (Result<[Animes], HttpErrorType>) -> Void)
}
