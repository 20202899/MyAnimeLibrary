//
//  LayoutDrawable.swift
//  iOSCommons
//
//  Created by Carlos Silva on 26/02/23.
//

import Foundation
import UIKit


public protocol LayoutDrawable {
    var drawableView: UIView { get set }
    
    static func start() -> LayoutDrawable
}
