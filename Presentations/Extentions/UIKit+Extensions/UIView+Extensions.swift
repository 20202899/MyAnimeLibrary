//
//  UIView+Extensions.swift
//  Presentations
//
//  Created by Carlos Silva on 23/02/23.
//

import UIKit

extension UIView {
    func anchor(
        top: (NSLayoutYAxisAnchor, CGFloat)?,
        bottom: (NSLayoutYAxisAnchor, CGFloat)?,
        left: (NSLayoutXAxisAnchor, CGFloat)?,
        right: (NSLayoutXAxisAnchor, CGFloat)?
    ) {
        var constraints = [NSLayoutConstraint]()
        
        if let top = top {
            constraints.append(topAnchor.constraint(equalTo: top.0, constant: top.1))
        }
        
        if let bottom = bottom {
            constraints.append(bottomAnchor.constraint(equalTo: bottom.0, constant: -bottom.1))
        }
        
        if let left = left {
            constraints.append(leftAnchor.constraint(equalTo: left.0, constant: left.1))
        }
        
        if let right = right {
            constraints.append(rightAnchor.constraint(equalTo: right.0, constant: -right.1))
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func anchorSuperView(with padding: CGFloat = .zero) {
        guard let superview = superview else { return }
        
        var constraints = [NSLayoutConstraint]()
        constraints.append(topAnchor.constraint(equalTo: superview.topAnchor, constant: padding))
        constraints.append(bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding))
        constraints.append(leftAnchor.constraint(equalTo: superview.leftAnchor, constant: padding))
        constraints.append(rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -padding))
        NSLayoutConstraint.activate(constraints)
    }
}
