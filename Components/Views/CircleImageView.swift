//
//  CircleImage.swift
//  Presentations
//
//  Created by Carlos Silva on 26/02/23.
//

import UIKit

public final class CircleImageView: UIImageView {
    private static let smallSize: CGFloat = 30
    private static let normalSize: CGFloat = 40
    var currentSize: Size = .normal
    
    public enum Size {
        case small
        case normal
        
        var value: CGFloat {
            return self == .small ? smallSize : normalSize
        }
    }
    
    public init(size: Size = .normal) {
        super.init(frame: CGRect(x: .zero, y: .zero, width: size.value, height: size.value))
        currentSize = size
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        layer.masksToBounds = false
        layer.cornerRadius = currentSize.value / 2
        clipsToBounds = true
        
        heightAnchor.constraint(equalToConstant: currentSize.value).isActive = true
        widthAnchor.constraint(equalToConstant: currentSize.value).isActive = true
    }
}
