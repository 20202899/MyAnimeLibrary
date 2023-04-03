//
//  HeaderView.swift
//  Presentations
//
//  Created by Carlos Silva on 27/02/23.
//

import UIKit
import iOSCommons
import Components

final class HeaderView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.text = "Animes"
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.lineBreakStrategy = .hangulWordPriority
        return label
    }()
    
    lazy var profileImageView: CircleImageView = {
        let imageView = CircleImageView(size: .normal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "profile")
        return imageView
    }()
    
    lazy var closeButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "xmark")
        config.imageColorTransformer = UIConfigurationColorTransformer{ _ in
            return .secondaryLabel
        }
        config.buttonSize = .large
        config.cornerStyle = .capsule
        config.preferredSymbolConfigurationForImage = .init(font: .systemFont(ofSize: LayoutSpacing.s26.value))
        config.imagePlacement = .all
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        
        button.addAction(UIAction { _ in
            self.closeAction?()
        }, for: .touchUpInside)
        
        return button
    }()
    
    var closeAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: LayoutSpacing.s24.value),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        addSubview(profileImageView)
        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -LayoutSpacing.s24.value),
            profileImageView.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: LayoutSpacing.s16.value)
        ])
        
        addSubview(closeButton)
        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            closeButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -LayoutSpacing.s24.value),
            closeButton.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: LayoutSpacing.s16.value)
        ])
    }
}
