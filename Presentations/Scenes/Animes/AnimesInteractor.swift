//
//  AnimesInteractor.swift
//  Presentations
//
//  Created by Carlos Silva on 23/02/23.
//

import Foundation

final class AnimesInteractor: NSObject {
    private let animesWorker: AnimesWorker
    private let animesPresenter: AnimesPresenterProtocol
    
    init(animesWorker: AnimesWorker, animesPresenter: AnimesPresenterProtocol) {
        self.animesWorker = animesWorker
        self.animesPresenter = animesPresenter
    }
}

extension AnimesInteractor: AnimesInteractorProtocol {
    func fetchAnimes() {
        animesWorker.getAnimes { [weak self] result in
            guard let self = self else { return }
            let response = ShowAnimes.GetAnimes.Response(result: result)
            self.animesPresenter.presentAnimes(response: response)
        }
    }
}
