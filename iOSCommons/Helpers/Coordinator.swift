//
//  Coordinator.swift
//  Presentations
//
//  Created by Carlos Silva on 23/02/23.
//

import UIKit

public protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController? { get set }
    
    func start()
}
