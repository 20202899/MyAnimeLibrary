//
//  TransitionManager.swift
//  Presentations
//
//  Created by Carlos Silva on 01/03/23.
//

import Foundation
import UIKit
import iOSCommons

enum TransitionType {
    case present
    case dimiss
    case none
}

final class TransitionManager: NSObject {
    private let transitionDuration: Double = 1
    private let shrinkDuration: Double = 0.3
    var transition: TransitionType = .present
    var originFrame: CGRect = .zero
}

extension TransitionManager: UIViewControllerAnimatedTransitioning {
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        containerView.backgroundColor = .systemBackground
 
        guard let fromView = transitionContext.view(forKey: .from), let toView = transitionContext.view(forKey: .to), let detailView = toView as? DetailView, let animesView = fromView as? AnimesView, let listItem = animesView.selectedView else { return }
        
        toView.isHidden = true
        listItem.isHidden = true
        
        let originFrame = listItem.contentView.convert(listItem.contentView.frame, to: nil)
        let cardView = CardView(frame: originFrame)
        
        containerView.addSubview(cardView)
        containerView.addSubview(toView)
        
        NSLayoutConstraint.activate([
            cardView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            cardView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            cardView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
        ])
        
        detailView.titleLabel.text = listItem.titleLabel.text
        cardView.titleLabel.text = listItem.titleLabel.text
        cardView.animes = listItem.animes
        
        let shrinkAnimation = UIViewPropertyAnimator(duration: shrinkDuration, curve: .easeOut) {
            cardView.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
        }
        
        let sprintTiming = UISpringTimingParameters(dampingRatio: 0.4, initialVelocity: CGVector(dx: 1, dy: 1))
        
        let moveExpandAnimation = UIViewPropertyAnimator(duration: transitionDuration - shrinkDuration, timingParameters: sprintTiming)
        
        moveExpandAnimation.addAnimations {
            cardView.transform = CGAffineTransform(scaleX: 1, y: 1)
            cardView.contentTableViewHeightConstraint?.isActive = false
            cardView.containerViewLeftConstraint?.constant = .zero
            cardView.containerViewRightConstraint?.constant = .zero
            cardView.frame = toView.frame
            cardView.frame.origin.y = 44
            cardView.layoutIfNeeded()
            cardView.isLoadAllAnimes = true
            cardView.removeShadow()
            cardView.titleLabel.font = .systemFont(ofSize: 32, weight: .bold)
            cardView.titleLabel.numberOfLines = 2
            cardView.titleLabel.lineBreakMode = .byWordWrapping
            cardView.titleLabel.lineBreakStrategy = .hangulWordPriority
        }
        
        moveExpandAnimation.addCompletion { _ in
            cardView.isHidden = true
            toView.isHidden = false
            transitionContext.completeTransition(true)
        }
        
        shrinkAnimation.addCompletion { _ in
            moveExpandAnimation.startAnimation()
        }
        
        shrinkAnimation.startAnimation()
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
