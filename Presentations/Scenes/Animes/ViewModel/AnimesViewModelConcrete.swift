//
//  AnimesViewModelConcrete.swift
//  Presentations
//
//  Created by Carlos Silva on 02/03/23.
//

import Foundation
import Core

final class AnimesViewModelConcrete: NSObject {
    private let getTodayAnimesUseCase: GetTodayAnimesUseCase
    private let coordinator: AnimesCoordinatorProtocol
    
    var selectedAnimes: [Anime] = [] {
        didSet {
            coordinator.navigateToDetailAnime(animes: selectedAnimes)
        }
    }
    
    init(getTodayAnimesUseCase: GetTodayAnimesUseCase, coordinator: AnimesCoordinatorProtocol) {
        self.getTodayAnimesUseCase = getTodayAnimesUseCase
        self.coordinator = coordinator
    }
}

extension AnimesViewModelConcrete: AnimesViewModelProtocol {
    func getTodayAnimes(completion: @escaping (Result<[Animes], HttpErrorType>) -> Void) {
        getTodayAnimesUseCase.getTodayAnimes(completion: completion)
    }
}
