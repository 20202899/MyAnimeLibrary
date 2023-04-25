//
//  ItemCollectionTableViewCell.swift
//  Presentations
//
//  Created by Carlos Silva on 01/03/23.
//

import Foundation
import UIKit
import iOSCommons
import Components
import Core
import SDWebImage

final class ItemCollectionTableViewCell: UITableViewCell, Identifiable {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    var loadAllAnimes = false {
        didSet {
            if loadAllAnimes {
                contentTableView.reloadData()
            }
        }
    }
    
    var containerViewLeftConstraint: NSLayoutConstraint?
    var containerViewRightConstraint: NSLayoutConstraint?
    var titleLabelTopConstraint: NSLayoutConstraint?
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .tertiarySystemBackground
        view.clipsToBounds = false
        return view
    }()
    
    private lazy var contentTableView: ResizeTableView = {
        let tableView = ResizeTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = .clear
        tableView.register(AnimeItemTableViewCell.self, forCellReuseIdentifier: AnimeItemTableViewCell.identifier)
        tableView.dataSource = self
        tableView.clipsToBounds = true
        tableView.estimatedRowHeight = 85
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    private var isTouchAnimate: Bool = false {
        didSet {
            let springProvider = UISpringTimingParameters(dampingRatio: 0.60, initialVelocity: .init(dx: 4, dy: 4))
            let animate = UIViewPropertyAnimator(duration: 0.4, timingParameters: springProvider)
            
            animate.addAnimations { [weak self] in
                guard let self = self else { return }
                
                self.containerView.transform = self.isTouchAnimate ? CGAffineTransform(scaleX: 0.85, y: 0.85) : CGAffineTransform(scaleX: 1, y: 1)
            }
            
            animate.startAnimation()
        }
    }
    
    var animes: [Anime] = [] {
        didSet {
            guard !animes.isEmpty else { return }
            contentTableView.reloadData()
        }
    }
    var didAction: ((ItemCollectionTableViewCell)->Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        addShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        selectionStyle = .none
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        gesture.cancelsTouchesInView = true
        containerView.addGestureRecognizer(gesture)
        contentView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutSpacing.s8.value),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LayoutSpacing.s8.value)
        ])
        
        containerViewLeftConstraint = containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: LayoutSpacing.s24.value)
        
        containerViewRightConstraint = containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -LayoutSpacing.s24.value)
        
        containerViewLeftConstraint?.isActive = true
        containerViewRightConstraint?.isActive = true
        
        containerView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: LayoutSpacing.s24.value),
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -LayoutSpacing.s24.value)
        ])
        
        titleLabelTopConstraint = titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: LayoutSpacing.s16.value)
        
        titleLabelTopConstraint?.isActive = true
        
        containerView.addSubview(contentTableView)
        NSLayoutConstraint.activate([
            contentTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            contentTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            contentTableView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            contentTableView.rightAnchor.constraint(equalTo: containerView.rightAnchor)
        ])
    }
    
    @objc private func didTapView() {
        didAction?(self)
    }
    
    func addShadow() {
        containerView.layer.cornerRadius = LayoutSpacing.s20.value
        containerView.layer.shadowColor = UIColor.darkGray.cgColor
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowRadius = 10
        containerView.layer.shadowOffset = CGSize(width: -1, height: 2)
    }
    
    func removeShadow() {
        containerView.layer.cornerRadius = .zero
        containerView.layer.shadowColor = UIColor.clear.cgColor
        containerView.layer.shadowOpacity = .zero
        containerView.layer.shadowRadius = .zero
        containerView.layer.shadowOffset = .zero
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
    }
}

extension ItemCollectionTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadAllAnimes ? animes.count : 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AnimeItemTableViewCell.identifier) as? AnimeItemTableViewCell else {
            return AnimeItemTableViewCell(style: .default, reuseIdentifier: AnimeItemTableViewCell.identifier)
        }
        
        let anime = animes[indexPath.row]
        if let url = URL(string: anime.attributes.posterImage.original) {
            cell.animeImageView.sd_setImage(with: url)
        }
        
        cell.titleLabel.text = anime.title
        cell.descriptionLabel.text = anime.attributes.description
        
        return cell
    }
}
