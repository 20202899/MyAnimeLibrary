//
//  MainCoordinator.swift
//  MyAnimeLibrary
//
//  Created by Carlos Silva on 24/02/23.
//

import iOSCommons
import UIKit
import Presentations

final class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let childCoordinator = AnimesCoordinator(navigationController: navigationController)
        childCoordinators.append(childCoordinator)
        childCoordinator.start()
    }
}
