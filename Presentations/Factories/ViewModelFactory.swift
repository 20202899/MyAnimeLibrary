//
//  ViewModelFactory.swift
//  Presentations
//
//  Created by Carlos Silva on 02/03/23.
//

import Core

func makeAnimesViewModel(coordinator: AnimesCoordinatorProtocol) -> AnimesViewModelProtocol {
    return AnimesViewModelConcrete(getAnimesUseCase: makeGetAnimesUseCase(), coordinator: coordinator, seasonProvider: makeSeasonProvider())
}

func makeAnimeDetailViewModel(coordinator: AnimesCoordinator, animes: [Anime]) -> DetailAnimeViewModelProtocol {
    return DetailAnimeViewModelConcrete(animes: animes, coordinator: coordinator)
}
