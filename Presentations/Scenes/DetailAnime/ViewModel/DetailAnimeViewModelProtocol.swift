//
//  AnimeDetailViewModelProtocol.swift
//  Presentations
//
//  Created by Carlos Silva on 04/03/23.
//

import Foundation
import Core
import RxRelay

protocol DetailAnimeViewModelProtocol {
    var animes: [Anime] { get }
    var isBack: BehaviorRelay<Bool> { get set }
}
