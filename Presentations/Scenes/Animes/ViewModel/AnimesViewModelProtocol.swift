//
//  AnimesViewModelProtocol.swift
//  Presentations
//
//  Created by Carlos Silva on 02/03/23.
//

import Foundation
import Core

protocol AnimesViewModelProtocol {
    var selectedAnimes: [Anime] { get set }
    func getTodayAnimes(completion: @escaping (Result<[Animes], HttpErrorType>) -> Void)
}
