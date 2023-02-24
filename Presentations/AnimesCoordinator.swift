//
//  MainCoordinator.swift
//  Presentations
//
//  Created by Carlos Silva on 23/02/23.
//

import UIKit
import iOSCommons

public final class AnimesCoordinator: Coordinator {
    public var childCoordinators: [Coordinator] = []
    public var navigationController: UINavigationController?
    
    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let viewController = makeAnimesViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
