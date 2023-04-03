//
//  MainCoordinator.swift
//  Presentations
//
//  Created by Carlos Silva on 23/02/23.
//

import UIKit
import iOSCommons
import Core

public protocol AnimesCoordinatorProtocol: Coordinator {
    func back()
    func navigateToDetailAnime(animes: [Anime])
}

public final class AnimesCoordinator: NSObject, AnimesCoordinatorProtocol {
    public var childCoordinators: [Coordinator] = []
    public var navigationController: UINavigationController?
    private let transitionManager = TransitionManager()
    
    public init(navigationController: UINavigationController?) {
        super.init()
        self.navigationController = navigationController
        self.navigationController?.delegate = transitionManager
    }
    
    public func start() {
        let viewController = makeAnimesViewController(coordinator: self)
        navigationController?.show(viewController, sender: nil)
    }
    
    public func navigateToDetailAnime(animes: [Anime]) {
        let viewController = makeDetailAnimeViewController(coordinator: self, animes: animes)
        transitionManager.transition = .present
        navigationController?.show(viewController, sender: nil)
    }
    
    public func back() {
        transitionManager.transition = .dimiss
        navigationController?.popViewController(animated: true)
    }
}
