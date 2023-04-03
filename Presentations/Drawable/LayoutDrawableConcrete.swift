//
//  LayoutDrawableConcrete.swift
//  Presentations
//
//  Created by Carlos Silva on 26/02/23.
//

import Foundation
import iOSCommons
import UIKit

public final class LayoutDrawableConcrete: LayoutDrawable {
    public var drawableView: UIView = DetailAnimeViewController(viewModel: DetailAnimeViewModelConcrete(animes: [], coordinator: AnimesCoordinator(navigationController: UINavigationController()))).view
    
    public static func start() -> LayoutDrawable {
        return LayoutDrawableConcrete()
    }
}
