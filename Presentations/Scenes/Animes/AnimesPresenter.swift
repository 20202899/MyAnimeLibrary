//
//  AnimesPresenter.swift
//  Presentations
//
//  Created by Carlos Silva on 24/02/23.
//

import Foundation
import Core

final class AnimesPresenter: NSObject {
    private weak var displayLogic: AnimesDisplayLogicProtocol?
    
    init(displayLogic: AnimesDisplayLogicProtocol) {
        self.displayLogic = displayLogic
    }
}

extension AnimesPresenter: AnimesPresenterProtocol {
    func presentAnimes(response: ShowAnimes.GetAnimes.Response) {
        switch response.result {
        case .failure:
            displayLogic?.showError(message: "Test Error")
            
        case .success(let animes):
            displayLogic?.showAnimes(viewModel: animes.toViewModel())
        }
    }
}

extension Animes {
    func toViewModel() -> ShowAnimes.GetAnimes.ViewModel {
        return ShowAnimes.GetAnimes.ViewModel(animes: data.map { anime in
            let name = anime.attributes.titles.toName()
            return ShowAnimes.GetAnimes.ViewModel.AnimeDisplay(name: name, imageUrl: anime.attributes.posterImage.large)
        })
    }
}
