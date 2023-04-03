//
//  TransitionManager.swift
//  Presentations
//
//  Created by Carlos Silva on 01/03/23.
//

import Foundation
import UIKit

enum TransitionType {
    case present
    case dimiss
    case none
}

final class TransitionManager: NSObject {
    private let transitionDuration: Double = 1
    var transition: TransitionType = .present
    var originFrame: CGRect = .zero
    var dismissCompletion: (() -> Void)?
}

extension TransitionManager: UIViewControllerAnimatedTransitioning {
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        let fromView = transitionContext.view(forKey: .from)!
        let recipeView = transition == .present ? toView : fromView
        
        let initialFrame = transition == .present ? originFrame : recipeView.frame
        let finalFrame = transition == .present ? recipeView.frame : originFrame
        
        let xScaleFactor = transition == .present ?
          initialFrame.width / finalFrame.width :
          finalFrame.width / initialFrame.width
        
        let yScaleFactor = transition == .present ?
          initialFrame.height / finalFrame.height :
          finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        if transition == .present {
          recipeView.transform = scaleTransform
          recipeView.center = CGPoint(
            x: initialFrame.midX,
            y: initialFrame.midY)
          recipeView.clipsToBounds = true
        }
        
        recipeView.layer.cornerRadius = transition == .present ? 20.0 : 0.0
        recipeView.layer.masksToBounds = true
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(recipeView)
        
        UIView.animate(
          withDuration: transitionDuration,
          delay:0.0,
          usingSpringWithDamping: 0.5,
          initialSpringVelocity: 0.2,
          animations: {
              recipeView.transform = self.transition == .present ? .identity : scaleTransform
            recipeView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
              recipeView.layer.cornerRadius = self.transition == .present ? 20.0 : 0.0
        }, completion: { _ in
            if self.transition != .present {
            self.dismissCompletion?()
            }
          transitionContext.completeTransition(true)
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
}

extension TransitionManager: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}
