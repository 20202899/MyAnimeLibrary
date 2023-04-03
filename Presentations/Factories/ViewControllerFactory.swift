//
//  ViewControllerFactory.swift
//  Presentations
//
//  Created by Carlos Silva on 24/02/23.
//

import UIKit
import Core

func makeAnimesViewController(coordinator: AnimesCoordinatorProtocol) -> UIViewController {
    return AnimesViewController(viewModel: makeAnimesViewModel(coordinator: coordinator))
}

func makeDetailAnimeViewController(coordinator: AnimesCoordinator, animes: [Anime]) -> DetailAnimeViewController {
    return DetailAnimeViewController(viewModel: makeAnimeDetailViewModel(coordinator: coordinator, animes: animes))
}
