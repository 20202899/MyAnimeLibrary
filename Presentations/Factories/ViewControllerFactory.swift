//
//  ViewControllerFactory.swift
//  Presentations
//
//  Created by Carlos Silva on 24/02/23.
//

import UIKit

func makeAnimesViewController() -> UIViewController {
    let vc = AnimesViewController()
    let presenter = AnimesPresenter(displayLogic: vc)
    let worker = AnimesWorker(getAnimesUseCase: makeGetAnimesUseCase())
    let interactor = AnimesInteractor(animesWorker: worker, animesPresenter: presenter)
    vc.interactor = interactor
    return vc
}
