//
//  CardView.swift
//  Presentations
//
//  Created by Carlos Silva on 06/04/23.
//

import Core
import UIKit
import Components
import iOSCommons

final class CardView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Tendências da semana"
        label.numberOfLines = 2
        return label
    }()
    
    var isLoadAllAnimes = false {
        didSet {
            if isLoadAllAnimes {
                contentTableView.reloadData()
            }
        }
    }
    
    var contentTableViewHeightConstraint: NSLayoutConstraint?
    var containerViewLeftConstraint: NSLayoutConstraint?
    var containerViewRightConstraint: NSLayoutConstraint?
    
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
    
    var animes: [Anime] = [] {
        didSet {
            guard !animes.isEmpty else { return }
            contentTableView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        addShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupViews() {
        backgroundColor = .clear
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: LayoutSpacing.s8.value),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -LayoutSpacing.s8.value)
        ])
        
        containerViewLeftConstraint = containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: LayoutSpacing.s24.value)
        containerViewRightConstraint = containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -LayoutSpacing.s24.value)
        
        containerViewLeftConstraint?.isActive = true
        containerViewRightConstraint?.isActive = true
        
        containerView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: LayoutSpacing.s24.value),
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -LayoutSpacing.s24.value),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: LayoutSpacing.s24.value)
        ])
        
        containerView.addSubview(contentTableView)
        NSLayoutConstraint.activate([
            contentTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: LayoutSpacing.s4.value),
            contentTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            contentTableView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            contentTableView.rightAnchor.constraint(equalTo: containerView.rightAnchor)
        ])
        
        contentTableViewHeightConstraint = contentTableView.heightAnchor.constraint(equalToConstant: 340)
        contentTableViewHeightConstraint?.isActive = true
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
}

extension CardView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isLoadAllAnimes ? animes.count : 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AnimeItemTableViewCell.identifier) as? AnimeItemTableViewCell else {
            return AnimeItemTableViewCell(style: .default, reuseIdentifier: AnimeItemTableViewCell.identifier)
        }
        
        let anime = animes[indexPath.row]
        if let url = URL(string: anime.attributes.posterImage.original) {
            cell.animeImageView.sd_setImage(with: url)
        }
        
        cell.titleLabel.text = anime.attributes.titles.en ?? anime.attributes.titles.en_jp
        cell.descriptionLabel.text = anime.attributes.description
        
        return cell
    }
}
