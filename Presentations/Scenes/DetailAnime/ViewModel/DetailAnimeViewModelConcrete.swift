//
//  AnimeDetailViewModelConcrete.swift
//  Presentations
//
//  Created by Carlos Silva on 04/03/23.
//

import Foundation
import UIKit
import Core

final class DetailAnimeViewModelConcrete: NSObject, DetailAnimeViewModelProtocol {
    private let coordinator: AnimesCoordinator
    let animes: [Anime]
    var isBack: Bool = false {
        didSet {
            coordinator.back()
        }
    }
    
    init(animes: [Anime], coordinator: AnimesCoordinator) {
        self.animes = animes
        self.coordinator = coordinator
    }
}
