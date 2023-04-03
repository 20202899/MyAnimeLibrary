//
//  AnimeItemTableViewCell.swift
//  Presentations
//
//  Created by Carlos Silva on 02/03/23.
//

import UIKit
import iOSCommons

final class AnimeItemTableViewCell: UITableViewCell, Identifiable {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .callout)
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = .secondaryLabel
        label.numberOfLines = 2
        return label
    }()
    
    lazy var animeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupViews() {
        selectionStyle = .none
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        contentView.addSubview(animeImageView)
        NSLayoutConstraint.activate([
            animeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutSpacing.s20.value),
            animeImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: LayoutSpacing.s20.value),
            animeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LayoutSpacing.s12.value),
            animeImageView.widthAnchor.constraint(equalToConstant: 50),
            animeImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: animeImageView.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: animeImageView.rightAnchor, constant: LayoutSpacing.s16.value),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -LayoutSpacing.s20.value)
        ])
        
        contentView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutSpacing.s4.value),
            descriptionLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
            descriptionLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor)
        ])
    }
}
