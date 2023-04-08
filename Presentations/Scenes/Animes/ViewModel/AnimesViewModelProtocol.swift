//
//  AnimesViewModelProtocol.swift
//  Presentations
//
//  Created by Carlos Silva on 02/03/23.
//

import Foundation
import Core
import RxRelay

protocol AnimesViewModelProtocol {
    var selectedAnimes: [Anime] { get set }
    var animes: PublishRelay<[Animes]> { get set }
    func didLoadAnimes()
}
